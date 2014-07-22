require 'fog'

module SkimReaper
  class Base
    def config
      fail SkimReaper::InvalidCLIOptionsError, 'YAML Config file not specified' unless defined? $CONFIG_PATH
      fail SkimReaper::FileNotFoundError, "Could not find YAML config file '#{CONFIG_PATH}'" unless File.exist? $CONFIG_PATH

      @config ||= YAML.load_file(config_path)
    end
  end
end
