require 'logger'
require 'yaml'

require 'skim_reaper/version'
require 'skim_reaper/base'
require 'skim_reaper/instances'

module SkimReaper
  InvalidCLIOptionsError = Class.new(Exception)
  FileNotFoundError = Class.new(Exception)

  def self.log
    @logger ||= Logger.new(STDOUT)
  end

  def self.config
    @config ||= YAML.load_file($OPTIONS[:yaml])
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.build_scaffold(path)
    FileUtils.cp_r File.join root, './config', path
    FileUtils.cp_r File.join root, './rules', path
  end
end
