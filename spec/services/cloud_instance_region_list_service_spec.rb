require 'rails_helper'

RSpec.describe CloudInstanceRegionListService do

  let(:client_class) { object_double("Aws::EC2::Client") }
  let(:client) { Aws::EC2::Client.new(stub_responses: true) }
  subject { described_class.new(client_class: client_class).call }

  before do
    expect(client_class).to receive(:new).and_return(client)
  end

  context "with available regions" do
    let(:data) do
      client.stub_data(
        :describe_regions,
        {
          regions: [
            { endpoint: "xx-west-1.amazonaws.com", region_name: "xx-west-1" },
            { endpoint: "xx-east-2.amazonaws.com", region_name: "xx-east-2" }
          ]
        }
      )
    end
    before { client.stub_responses(:describe_regions, data) }

    it "returns an array of regions" do
      is_expected.to match_array [ "xx-west-1", "xx-east-2" ]
    end
  end

end
