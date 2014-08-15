require 'fog'
require 'rspec/expectations'

module CloudSpec
  class Base
    include RSpec::Matchers

    def initialize
      mock?
      super
    end

    def process_account(_account = { 'access_key' => nil, 'secret_key' => nil })
      fail NotImplementedError, 'This method should be defined in the child class'
    end

    def load_rules
      CloudSpec.log.debug 'loading rules ...'

      rules_path = File.expand_path($OPTIONS[:rules])
      Dir["#{rules_path}/**/*.rb"].each do |file|
        require file
      end
    end

    def regions(credentials)
      CloudSpec.log.debug 'getting regions ...'
      aws_client = compute_client(credentials)
      aws_client.describe_regions.body['regionInfo'].map { |region| region['regionName'] }
    end

    def compute_client(credentials = { 'access_key' => '', 'secret_key' => '' }, region = nil)
      CloudSpec.log.debug 'creating compute client ...'
      Fog::Compute.new(
        provider:               'AWS',
        aws_access_key_id:      credentials['access_key'],
        aws_secret_access_key:  credentials['secret_key'],
        region:                 region
      )
    end

    def mock?
      CloudSpec.log.debug 'Fog Mocking enabled.'
      Fog.mock! if $OPTIONS[:mock]
    end
  end
end
