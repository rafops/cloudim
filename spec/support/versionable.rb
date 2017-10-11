RSpec.shared_examples "versionable" do |**options|

  let(:identifier_column) { options[:identifier_column] || "id"            }
  let(:version_column)    { options[:version_column]    || "created_at"    }
  let(:model_scope)       { options[:model_scope]       || described_class }
  let(:now)               { Time.now                                       }

  context "with historic records" do
    let(:records) do
      [
        { "#{identifier_column}" => "item1", "#{version_column}" => now + 5 },
        { "#{identifier_column}" => "item1", "#{version_column}" => now + 3 },
        { "#{identifier_column}" => "item1", "#{version_column}" => now + 1 },
        { "#{identifier_column}" => "item2", "#{version_column}" => now + 4 },
        { "#{identifier_column}" => "item2", "#{version_column}" => now + 2 }
      ]
    end
    let(:head_records) do
      model_scope
        .where("#{version_column} >= ?", now + 4)
        .limit(2)
        .pluck("#{identifier_column}", "#{version_column}")
    end
    subject do
      model_scope
        .head
        .pluck("#{identifier_column}", "#{version_column}")
    end

    before do
      records.each do |record|
        model_scope.create(record)
      end
    end

    it "only shows the head records" do
      is_expected.to match_array head_records
    end
  end

  context "with records containing duplicated identifier and version columns" do
    let(:records) do
      [
        { "#{identifier_column}" => "item1", "#{version_column}" => now + 1 },
        { "#{identifier_column}" => "item2", "#{version_column}" => now + 2 },
        { "#{identifier_column}" => "item2", "#{version_column}" => now + 2 }
      ]
    end

    it "prohibits duplicated records" do
      expect { records.each { |record| model_scope.create(record) } }.to raise_error ActiveRecord::RecordNotUnique
    end
  end

end
