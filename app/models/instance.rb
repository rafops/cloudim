class Instance < ApplicationRecord
  include Versionable
  versionable :name
end
