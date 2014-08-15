# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cloudspec/version'

Gem::Specification.new do |spec|
  spec.name          = 'cloudspec'
  spec.version       = CloudSpec::VERSION
  spec.authors       = ['Jonathan "Jof" Lassoff', 'Ryan Greget']
  spec.email         = ['jof@lookout.com', 'regret@lookout.com']
  spec.summary       = %q{Simple tool to harvest dead weight in AWS}
  spec.description   = spec.summary
  spec.homepage      = 'https://source.flexilis.local/ops/cloudspec'
  spec.license       = ''

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'fog', '~> 1.23'
  spec.add_dependency 'rspec-expectations', '~> 3.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rubocop'
end
