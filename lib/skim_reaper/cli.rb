require 'thor'

module SkimReaper
  class CLI < Thor
    class_option :verbose, type: :boolean, desc: 'Enable verbose logging', aliases: '-v'
    class_option :yaml, type: :string, required: true, aliases: '-y', desc: 'The path to the chef-service yaml config file'

    no_tasks do
      def validate
        $CONFIG_PATH = options[:yaml]
        fail SkimReaper::FileNotFoundError, "Could not find YAML config file '#{$CONFIG_PATH}'" unless File.exist? $CONFIG_PATH
      end
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
