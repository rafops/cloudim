module Versionable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def versionable(identifier_column, version_column = "created_at")
      scope :head, -> do
        joins(%{
          INNER JOIN (
            SELECT #{identifier_column}, MAX(#{version_column}) AS #{version_column}_head
            FROM #{table_name}
            GROUP BY #{identifier_column}
          ) #{table_name}_head
          ON  #{table_name}.#{identifier_column} = #{table_name}_head.#{identifier_column}
          AND #{table_name}.#{version_column}    = #{table_name}_head.#{version_column}_head
        })
      end
    end
  end
end