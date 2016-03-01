module AMZN
  module SecurityGroupRules
#  <Fog::Compute::AWS::SecurityGroup
#    name="default",
#    description="default security group",
#    group_id="sg-12345678",
#    ip_permissions=[{"groups"=>[], "ipRanges"=>[{"cidrIp"=>"0.0.0.0/0"}], "ipProtocol"=>"tcp", "fromPort"=>22, "toPort"=>22}],
#    ip_permissions_egress=[],
#    owner_id="123456789012",
#    vpc_id=nil,
#    tags={}
#  >
    def evaluate(group)
      group.ip_permissions.each do |ip_permission|
        ip_permission['ipRanges'].each do |range|
          if range.has_value? '0.0.0.0/0'
            expect(ip_permission['fromPort']).to eq(80).or eq(443)
          end
        end
      end
      expect(group.vpc_id).to_not be_nil, 'expected group to belong to VPC'
    end
  end
end
