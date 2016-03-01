module AMZN
  module InstanceRules
# <Fog::Compute::AWS::Server
#   id="i-12345678",
#   ami_launch_index=0,
#   associate_public_ip=nil,
#   availability_zone="us-east-1a",
#   block_device_mapping=[{"deviceName"=>"/dev/sda1", "volumeId"=>"vol-12345678", "status"=>"attached", "attachTime"=>2014-07-10 21:44:24 UTC, "deleteOnTermination"=>false}],
#   network_interfaces=[],
#   client_token="ckgps1234567890123",
#   dns_name="ec2-11-22-33-44.compute-1.amazonaws.com",
#   ebs_optimized=false,
#   groups=["default", "other"],
#   flavor_id="m4.large",
#   hypervisor="xen",
#   iam_instance_profile={},
#   image_id="ami-abcd1234",
#   kernel_id="aki-abcd1234",
#   key_name="default",
#   created_at=2014-07-10 21:44:40 UTC,
#   lifecycle=nil,
#   monitoring=false,
#   placement_group=nil,
#   platform=nil,
#   product_codes=[],
#   private_dns_name="ip-11-22-33-44.ec2.internal",
#   private_ip_address="11.22.33.44",
#   public_ip_address="22.33.44.55",
#   ramdisk_id=nil,
#   reason=nil,
#   requester_id=nil,
#   root_device_name=nil,
#   root_device_type="ebs",
#   security_group_ids=["sg-abcd1234", "sg-1234abcd"],
#   source_dest_check=nil,
#   spot_instance_request_id=nil,
#   state="running",
#   state_reason={},
#   subnet_id=nil,
#   tenancy="default",
#   tags={"Name"=>"default"},
#   user_data=nil,
#   virtualization_type="paravirtual",
#   vpc_id=nil
# >

    def evaluate(instance)
      expect(instance.tags).to have_key('Name'), 'expected instance.tags to have key "Name"'
      expect(instance.flavor_id).to eq('m3.large'), "expected instance.flavor_id to equal 'm3.large', got #{instance.flavor_id}"
      expect(instance.vpc_id).to_not be_nil, 'expected instance to belong to VPC'
    end
  end
end
