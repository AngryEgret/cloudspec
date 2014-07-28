require 'fog'

module SkimReaper
  class Base
    def config
      @config ||= YAML.load_file(config_path)
    end
  end
end
