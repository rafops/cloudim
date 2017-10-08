require 'rails_helper'

RSpec.describe CloudInstancesListService do  
  let(:client_class) { object_double("Aws::EC2::Client") }
  let(:client) { Aws::EC2::Client.new(stub_responses: true) }
  subject { described_class.new(client_class: client_class) }

  before do
    expect(client_class).to receive(:new).and_return(client)
  end

  it "returns an empty array" do
    expect(subject.call).to eq []
  end

  context 'with existing instances' do
    let(:data) do
      client.stub_data(
        :describe_instances,
        {
          reservations: [
            instances: [
              { instance_id: "i-0123456789abcdef0", tags: [{ key: "Name", value: "primary" }] },
              { instance_id: "i-0123456789abcdef1", tags: [{ key: "Name", value: "secondary" }] }
            ]
          ]
        }
      )
    end
    before { client.stub_responses(:describe_instances, data) }

    it "returns an empty array" do
      expect(subject.call).to eq [
        { "name" => "primary" },
        { "name" => "secondary" }
      ]
    end
  end
end
