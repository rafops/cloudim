module LatestScope
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
    def latest_scoped_by(key_column, serial_column: "created_at")
      scope :latest, -> do
        joins(%{
          INNER JOIN (
            SELECT #{key_column}, MAX(#{serial_column}) AS latest_#{serial_column}
            FROM #{table_name}
            GROUP BY #{key_column}
          ) #{table_name}_latest
          ON  #{table_name}.#{key_column}    = #{table_name}_latest.#{key_column}
          AND #{table_name}.#{serial_column} = #{table_name}_latest.latest_#{serial_column}
        })
      end
    end
  end
end