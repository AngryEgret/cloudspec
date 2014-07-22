require 'thor'

module SkimReaper
  class CLI < Thor
    def initialize(*args)
      super
      $CONFIG_PATH = options[:yaml]
    end

    class_option :verbose, type: :boolean, desc: 'Enable verbose logging', aliases: '-v'
    class_option :yaml, type: :string, required: true, aliases: '-y', desc: 'The path to the chef-service yaml config file'

    no_tasks do
    end

    desc 'instances', 'Harvest AWS instances'
    def instances
      instances = Instances.new
      SkimReaper.log.info instances.harvest
    rescue => e
        SkimReaper.log.error e.to_s
        exit 1
    end
  end
end
