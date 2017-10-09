RSpec.shared_examples "versionable" do |identifier_column, version_column|
  version_column ||= "created_at"

  let(:five_days_ago)  { 5.days.ago }
  let(:four_days_ago)  { 4.days.ago }
  let(:three_days_ago) { 3.days.ago }
  let(:two_days_ago)   { 2.days.ago }
  let(:one_day_ago)    { 1.day.ago  }

  context "with historic records" do
    let(:records) do
      [
        { "#{identifier_column}" => "item1", "#{version_column}" => five_days_ago  },
        { "#{identifier_column}" => "item1", "#{version_column}" => three_days_ago },
        { "#{identifier_column}" => "item1", "#{version_column}" => one_day_ago    },
        { "#{identifier_column}" => "item2", "#{version_column}" => four_days_ago  },
        { "#{identifier_column}" => "item2", "#{version_column}" => two_days_ago   }
      ]
    end
    let(:head_records) do
      described_class
        .where("#{version_column} >= ?", two_days_ago)
        .limit(2)
        .pluck("#{identifier_column}", "#{version_column}")
    end
    subject do
      described_class
        .head
        .pluck("#{identifier_column}", "#{version_column}")
    end

    before do
      records.each do |record|
        described_class.create(record)
      end
    end
    
    it "only shows the head records" do
      is_expected.to match_array head_records
    end
  end

  context "with records containing duplicated identifier and version columns" do
    let(:records) do
      [
        { "#{identifier_column}" => "item1", "#{version_column}" => one_day_ago  },
        { "#{identifier_column}" => "item2", "#{version_column}" => two_days_ago },
        { "#{identifier_column}" => "item2", "#{version_column}" => two_days_ago }
      ]
    end

    it "prohibits duplicated records" do
      expect { records.each { |record| described_class.create(record) } }.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
