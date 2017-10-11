require 'rails_helper'
require 'support/versionable'

RSpec.describe Instance, type: :model do
  include_examples "versionable",
    identifier_column: "instance_id",
    version_column: "valid_until",
    model_scope: described_class.where(
      # TODO: Factory Girl
      account: Account.find_or_create_by(
        name: "Default",
        profile: "default"
      ),
      region: "us-east-1"
    )
end
