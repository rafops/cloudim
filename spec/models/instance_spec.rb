require 'rails_helper'
require 'support/latest_scoped_by'

RSpec.describe Instance, type: :model do
  include_examples "latest_scoped_by", "name"
end
