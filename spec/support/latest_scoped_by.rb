RSpec.shared_examples "latest_scoped_by" do |key_column, serial_column|
  serial_column ||= "created_at"

  let(:five_days_ago)  { 5.days.ago }
  let(:four_days_ago)  { 4.days.ago }
  let(:three_days_ago) { 3.days.ago }
  let(:two_days_ago)   { 2.days.ago }
  let(:one_day_ago)    { 1.day.ago  }

  context "with historic records" do
    let(:records) do
      [
        { "#{key_column}" => "item1", "#{serial_column}" => five_days_ago  },
        { "#{key_column}" => "item1", "#{serial_column}" => three_days_ago },
        { "#{key_column}" => "item1", "#{serial_column}" => one_day_ago    },
        { "#{key_column}" => "item2", "#{serial_column}" => four_days_ago  },
        { "#{key_column}" => "item2", "#{serial_column}" => two_days_ago   }
      ]
    end
    let(:latest_records) do
      described_class
        .where("#{serial_column} >= ?", two_days_ago)
        .limit(2)
        .pluck("#{key_column}", "#{serial_column}")
    end
    subject do
      described_class
        .latest
        .pluck("#{key_column}", "#{serial_column}")
    end

    before do
      records.each do |record|
        described_class.create(record)
      end
    end
    
    it "only shows the most recent records" do
      is_expected.to match_array latest_records
    end
  end

  context "with records containing duplicated key and serial columns" do
    let(:records) do
      [
        { "#{key_column}" => "item1", "#{serial_column}" => one_day_ago  },
        { "#{key_column}" => "item2", "#{serial_column}" => two_days_ago },
        { "#{key_column}" => "item2", "#{serial_column}" => two_days_ago }
      ]
    end

    it "prohibits duplicated records" do
      expect { records.each { |record| described_class.create(record) } }.to raise_error ActiveRecord::RecordNotUnique
    end
  end
end
