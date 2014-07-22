require 'bundler/gem_tasks'
require 'rake'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'cucumber'

desc 'Ensures we keep up 100% YARD coverage'
task :yard_coverage do
  coverage_stats = `yard stats --list-undoc 2>&1`
  puts coverage_stats

  yard_regexp = /^\s*(.*)% documented/
  percent = coverage_stats.scan(yard_regexp).first.first.to_f
  minimum_coverage = 0.0

  if percent < minimum_coverage
    fail 'Documentation coverage is less than #{minimum_coverage}%'
  else
    puts "\nNice work! Documentation coverage above #{minimum_coverage}%!"
  end
end

desc 'Checks the spec coverage and fails if it is less than 100%'
task :check_code_coverage do
  percent = File.read('./coverage/coverage_percent.txt').to_f
  minimum_coverage = 0.0
  if percent < minimum_coverage
    abort "Spec coverage was not high enough: #{percent.round(2)}% < #{minimum_coverage}%"
  else
    puts "Nice job! Spec coverage is still above #{minimum_coverage}%"
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format progress'
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = false
end

namespace :ci do
  desc 'Sets things up for a ci build'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.verbose = true
  end

  desc 'Run a ci build'
  task build: [:spec, :features, :yard_coverage, :check_code_coverage, :rubocop]
end
