describe CloudSpec::Instances do
  let(:instances){ CloudSpec::Instances.new }
  let(:credentials){ { 'access_key' => '', 'secret_key' => '' } }


  before(:each) do
    allow(CloudSpec).to receive_message_chain(:log, :debug)
    allow(CloudSpec).to receive_message_chain(:log, :warn)
    allow(CloudSpec).to receive(:options) {
      {
        mock: true,
        dry_run: true,
        yaml: 'config/template.yml',
        rules: './rules/',
        verbose: false,
      }
    }
  end

  describe '.harvest' do
    it 'should load the rules' do
      expect(instances).to receive(:load_rules)
      expect(CloudSpec::Instances).to receive(:include_rules)
      expect(instances).to receive(:process_account).at_least(:once)

      instances.harvest
    end
  end

  describe '.include_rules' do
    it 'should implement the evaluate method from InstanceRules' do
      instances.load_rules
      CloudSpec::Instances.include_rules

      expect( instances ).to respond_to :evaluate
    end
  end

  describe '.evaluate_instance' do
    pending
  end

  describe '.instances' do
    it 'should return an Array of instances' do
      expect( instances.instances(credentials, 'us-east-1') ).to be_an_instance_of(Fog::Compute::AWS::Servers)
    end
  end

  describe '.process_account' do
    pending
  end
end
