module CloudSpec
  class Instances < Base
    def harvest
      load_rules
      CloudSpec::Instances.include_rules

      CloudSpec.log.warn 'harvesting...'

      accounts = CloudSpec.config['aws']

      accounts.each do |account_name, credentials|
        process_account(account_name, credentials)
      end
    end

    def self.include_rules
      CloudSpec.log.debug 'including rules ...'
      include InstanceRules
    end

    def evaluate_instance(account_name, region, instance)
      CloudSpec.log.debug "Evaluating instance #{instance.id} ..."
      begin
        evaluate(instance)
      rescue RSpec::Expectations::ExpectationNotMetError => e
        CloudSpec.log.error "[#{account_name}][#{region}][#{instance.id}] - " + e.to_s
      end
    end

    def instances(credentials, region)
      CloudSpec.log.debug 'getting instances ...'
      aws_client = compute_client(credentials, region)
      aws_client.servers
    end

    def process_account(account_name, credentials = { 'access_key' => nil, 'secret_key' => nil })
      CloudSpec.log.debug "processing account #{account_name} ..."
      regions(credentials).each do |region|
        instances(credentials, region).each do |instance|
          evaluate_instance(account_name, region, instance)
        end
      end
    end
  end
end
