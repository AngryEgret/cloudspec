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
end
