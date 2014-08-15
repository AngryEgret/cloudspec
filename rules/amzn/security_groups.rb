module AMZN
  module SecurityGroupRules
    def evaluate(group)
      expect(group.name).to eq('default')
    end
  end
end
