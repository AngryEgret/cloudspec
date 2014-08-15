describe CloudSpec::Base do
  let(:base){ CloudSpec::Base.new }
  let(:credentials){ { 'access_key' => '', 'secret_key' => '' } }

  before(:each) do
    allow(CloudSpec).to receive_message_chain(:log, :debug)
    allow(CloudSpec).to receive(:options) {
      {
        mock: true,
        verbose: false,
        rules: './rules'
      }
    }
  end

  describe '.initialize' do
    it 'should call the mock? method' do
      expect_any_instance_of(CloudSpec::Base).to receive(:mock?)

      CloudSpec::Base.new
    end
  end

  describe '.process_account' do
    it 'should raise NotImplementedError' do
      expect{ base.process_account }.to raise_error(NotImplementedError)
    end
  end

  describe '.load_rules' do
    it 'should not raise error' do
      expect{ base.load_rules }.to_not raise_error
    end
  end

  describe '.regions' do
    it 'should return an array of regions' do
      expect( base.regions(credentials) ).to eq ["eu-west-1", "us-east-1"]
    end
  end

  describe '.compute_client' do
    it 'should return a Fog::Compute object' do
      expect( base.compute_client(credentials) ).to be_an_instance_of(Fog::Compute::AWS::Mock)
    end

    it 'should be able to consume a region argument' do
      expect( base.compute_client(credentials, 'eu-west-1').region ).to eq('eu-west-1')
      expect( base.compute_client(credentials, 'us-east-1').region ).to eq('us-east-1')
    end
  end

  describe '.mock?' do
    it 'should call Fog.mock! if the mock option is set' do
      expect(Fog).to receive(:mock!).at_least(:twice)

      base.mock?
    end

    it 'should not call Fog.mock! if the mock option is unset' do
      allow(CloudSpec).to receive(:options) {
        {
          mock: false,
          verbose: false,
          rules: './rules'
        }
      }

      expect(Fog).to_not receive(:mock!)

      base.mock?
    end
  end
end
