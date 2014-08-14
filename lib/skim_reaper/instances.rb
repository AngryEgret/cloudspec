module SkimReaper
  class Instances < Base
    def harvest
      load_rules
      SkimReaper::Instances.include_rules

      SkimReaper.log.warn 'harvesting...'

      accounts = SkimReaper.config['aws']

      accounts.each do |account_name, credentials|
        process_account(account_name, credentials)
      end
    end

    def self.include_rules
      SkimReaper.log.debug 'including rules ...'
      include InstanceRules
    end

    def process_account(account_name, credentials = { 'access_key' => nil, 'secret_key' => nil })
      aws_client = compute_client(credentials)

      regions = aws_client.describe_regions.body['regionInfo'].map { |region| region['regionName'] }

      regions.each do |region|
        aws_client = compute_client(credentials, region)
        instances = aws_client.servers

        instances.each do |instance|
          begin
            evaluate(instance)
          rescue RSpec::Expectations::ExpectationNotMetError => e
            SkimReaper.log.error "[#{account_name}][#{region}][#{instance.id}] - " + e.to_s
          end
        end
      end
    end
  end
end
