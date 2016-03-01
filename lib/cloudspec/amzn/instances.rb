module CloudSpec::AMZN
  class Instances < Base
    def self.include_rules
      CloudSpec.log.debug 'including rules ...'
      include AMZN::InstanceRules
    end

    def objects(credentials, region)
      CloudSpec.log.debug 'getting instances ...'
      aws_client = compute_client(credentials, region)
      aws_client.servers
    end

    def evaluate_object(account_name, region, object)
      CloudSpec.log.debug "Evaluating object #{object.id} ..."
      begin
        evaluate(object)
      rescue RSpec::Expectations::ExpectationNotMetError => e
        CloudSpec.log.error "[#{account_name}][#{region}][#{object.id}] - " + e.to_s
      end
    end
  end
end
