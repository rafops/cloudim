class Instance < ApplicationRecord
  include Versionable
  versionable identifier_column: "instance_id", version_column: "valid_until"

  belongs_to :account
  
  class << self
    def head_transaction(account, region, &block)
      transaction do
        block.call
        puts "count = #{head.where(account: account, region: region).count}"
      end
    end
  end

end
