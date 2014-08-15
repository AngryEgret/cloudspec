module CloudSpec::AMZN
  class SecurityGroups < Base
    def self.include_rules
      CloudSpec.log.debug 'including rules ...'
      include AMZN::SecurityGroupRules
    end

    def objects(credentials, region)
      CloudSpec.log.debug 'getting groups ...'
      aws_client = compute_client(credentials, region)
      aws_client.security_groups
    end

    def evaluate_object(account_name, region, object)
      CloudSpec.log.debug "Evaluating object #{object.group_id} ..."
      begin
        evaluate(object)
      rescue RSpec::Expectations::ExpectationNotMetError => e
        CloudSpec.log.error "[#{account_name}][#{region}][#{object.group_id}] - " + e.to_s
      end
    end

  end
end
