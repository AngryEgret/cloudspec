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

    def evaluate_instance(instance)
      SkimReaper.log.debug "Evaluating instance #{instance.id} ..."
      begin
        evaluate(instance)
      rescue RSpec::Expectations::ExpectationNotMetError => e
        SkimReaper.log.error "[#{account_name}][#{region}][#{instance.id}] - " + e.to_s
      end
    end

    def instances(credentials)
      SkimReaper.log.debug 'getting instances ...'
      aws_client = compute_client(credentials, region)
      aws_client.servers
    end

    def process_account(account_name, credentials = { 'access_key' => nil, 'secret_key' => nil })
      SkimReaper.log.debug "processing account #{account_name} ..."
      regions(credentials).each do |region|
        instances(credentials).each do |instance|
          evaluate_instance(instance)
        end
      end
    end
  end
end
