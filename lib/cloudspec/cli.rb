require 'thor'

module CloudSpec
  class CLI < Thor
    class_option :verbose, type: :boolean, desc: 'Enable verbose logging', aliases: '-v'

    def self.shared_options
      method_option :mock, type: :boolean, desc: 'Mock all cloud calls', aliases: '-m'
      method_option :dry_run, type: :boolean, desc: 'Non-destructive run', aliases: '-d'
      method_option :yaml, type: :string, required: true, aliases: '-y', desc: 'The path to the clould credentials yaml file'
      method_option :rules, type: :string, required: true, aliases: '-r', desc: 'The path to the rules'
    end

    no_tasks do
      def validate
        $OPTIONS = options

        $OPTIONS[:verbose] ? CloudSpec.log.level = Logger::DEBUG : CloudSpec.log.level = Logger::INFO

        fail CloudSpec::FileNotFoundError, "Could not find YAML config file '#{$OPTIONS[:yaml]}'" unless File.exist? $OPTIONS[:yaml]
        fail CloudSpec::FileNotFoundError, "Could not find rules path '#{$OPTIONS[:rules]}'" unless Dir.exist? $OPTIONS[:rules]
      end
    end

    desc 'init', 'Initialize a rules directory and credentials file'
    method_option :path, type: :string, required: true, aliases: '-p', desc: 'The path to create scaffolding within'
    def init
      fail CloudSpec::FileNotFoundError, "Could not find initialization path '#{options[:path]}'" unless Dir.exist? options[:path]

      CloudSpec.build_scaffold(options[:path])
    rescue => e
      CloudSpec.log.error e.to_s
      exit 1
    end

    desc 'instances', 'Harvest AWS instances'
    shared_options
    def instances
      validate

      instances = CloudSpec::Instances.new
      CloudSpec.log.info 'Beginning instance harvest ...'
      instances.harvest
      CloudSpec.log.info 'Instance harvest complete.'
    rescue => e
      CloudSpec.log.error e.to_s
      exit 1
    end
  end
end
