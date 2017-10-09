require 'rails_helper'

RSpec.describe CloudInstanceListService do

  let(:client_class) { object_double("Aws::EC2::Client") }
  let(:client) { Aws::EC2::Client.new(stub_responses: true) }
  subject { described_class.new(client_class: client_class).call }

  before do
    expect(client_class).to receive(:new).and_return(client)
  end

  it "returns an empty array" do
    is_expected.to be_empty
  end

  context "with existing instances" do
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
    let(:listed_instances) do
      [
        { "name" => "primary" },
        { "name" => "secondary" }
      ]
    end
    before { client.stub_responses(:describe_instances, data) }

    it "returns an array of instance model attributes" do
      is_expected.to match_array listed_instances
    end
  end

end
