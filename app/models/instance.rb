class Instance < ApplicationRecord
  include LatestScope
  latest_scoped_by :name
end
