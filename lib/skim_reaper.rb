require 'logger'
require 'yaml'

require 'skim_reaper/version'

module SkimReaper
  InvalidCLIOptionsError = Class.new(Exception)
  FileNotFoundError = Class.new(Exception)

  def self.log
    @logger ||= Logger.new(STDOUT)
  end
end
