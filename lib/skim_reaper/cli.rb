require 'thor'

module SkimReaper
  class CLI < Thor
    class_option :verbose, type: :boolean, desc: 'Enable verbose logging', aliases: '-v'
    class_option :yaml, type: :string, required: true, aliases: '-y', desc: 'The path to the clould credentials yaml file'
    class_option :rules, type: :string, required: true, aliases: '-r', desc: 'The path to the rules'
    class_option :mock, type: :boolean, desc: 'Mock all cloud calls', aliases: '-m'
    class_option :dry_run, type: :boolean, desc: 'Non-destructive run', aliases: '-d'

    no_tasks do
      def validate
        $OPTIONS = options

        $OPTIONS[:verbose] ? SkimReaper.log.level = Logger::DEBUG : SkimReaper.log.level = Logger::INFO

        fail SkimReaper::FileNotFoundError, "Could not find YAML config file '#{$OPTIONS[:yaml]}'" unless File.exist? $OPTIONS[:yaml]
        fail SkimReaper::FileNotFoundError, "Could not find rules path '#{$OPTIONS[:rules]}'" unless Dir.exist? $OPTIONS[:rules]
      end
    end

    desc 'init', 'Initialize a rules directory and credentials file'
    def init
      method_option :path, type: :string, required: true, aliases: '-p', desc: 'The path to create scaffolding within'

      fail SkimReaper::FileNotFoundError, "Could not find initialization path '#{options[:path]}'" unless Dir.exist? options[:path]

      SkimReaper::build_scaffold(options[:path])
    rescue => e
        SkimReaper.log.error e.to_s
        exit 1
    end

    desc 'instances', 'Harvest AWS instances'
    def instances
      validate

      instances = SkimReaper::Instances.new
      SkimReaper.log.info "Beginning instance harvest ..."
      instances.harvest
      SkimReaper.log.info "Instance harvest complete."
    rescue => e
        SkimReaper.log.error e.to_s
        exit 1
    end
  end
end
