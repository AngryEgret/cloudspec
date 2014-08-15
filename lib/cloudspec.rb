require 'logger'
require 'yaml'

require 'cloudspec/version'

require 'cloudspec/amzn/base'
require 'cloudspec/amzn/instances'

module CloudSpec
  InvalidCLIOptionsError = Class.new(Exception)
  FileNotFoundError = Class.new(Exception)

  def self.log
    @logger ||= Logger.new(STDOUT)
  end

  def self.config
    @config ||= YAML.load_file(CloudSpec.options[:yaml])
  end

  def self.options(options = nil)
    @options ||= options
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.build_scaffold(path)
    FileUtils.cp_r File.join(root, './config'), path
    FileUtils.cp_r File.join(root, './rules'), path
  end
end
