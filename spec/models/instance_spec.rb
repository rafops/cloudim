require 'rails_helper'
require 'support/versionable'

RSpec.describe Instance, type: :model do
  include_examples "versionable", "name"
end
