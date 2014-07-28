module SkimReaper
  class Instances < Base

    def harvest
      SkimReaper.log.warn "harvesting..."
    end

    def legacy
      aws_tokens = [
        ['access key id #1', 'secret key id #1'],
        ['access key id #2', 'secret key id #2']
      ]

      aws_tokens.each do |access_key_id, secret_access_key|
        ec2_for_regions = Fog::Compute.new(:provider => 'AWS', :aws_access_key_id => access_key_id, :aws_secret_access_key => secret_access_key)
        regions = ec2_for_regions.describe_regions.body['regionInfo'].map{|region|region['regionName']}
        regions.each do |region|
          ec2 = Fog::Compute.new(:provider => 'AWS', :aws_access_key_id => access_key_id, :aws_secret_access_key => secret_access_key, :region => region)
          instances = ec2.servers
          instances.each do |i|
            unless (i.tags['Team'] and
                    i.tags['Team'].length > 0 and
                    i.tags['Service'] and
                    i.tags['Service'].length > 0)
              i.destroy
            end
          end
        end
      end
    end
  end
end
