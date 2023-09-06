# frozen_string_literal: true

class CreatePageViews < ActiveRecord::Migration[7.0]
  def up # rubocop:disable Metrics/MethodLength
    sql = <<~SQL.squish
      CREATE OR REPLACE VIEW page_views AS
      SELECT
        pages.id AS page_id,
        schemes.name AS scheme_name,
        hosts.name AS host_name,
        paths.value AS path_value,
        queries.value AS query_value,

        CONCAT(
          schemes.name,
          '://',
          hosts.name,
          paths.value,
          CASE
            WHEN queries.value IS NULL THEN ''
            ELSE CONCAT('?', queries.value)
          END
        ) AS url
      FROM queries
      LEFT JOIN pages ON queries.id = pages.query_id
      LEFT JOIN paths ON queries.path_id = paths.id
      LEFT JOIN hosts ON paths.host_id = hosts.id
      LEFT JOIN schemes ON hosts.scheme_id = schemes.id
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def down
    sql = 'DROP VIEW IF EXISTS page_views'
    ActiveRecord::Base.connection.execute(sql)
  end
end
