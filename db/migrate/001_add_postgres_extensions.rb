# frozen_string_literal: true

class AddPostgresExtensions < ActiveRecord::Migration[7.0]
  # TODO: are all these actually required?
  EXTENSIONS = %w[plpgsql pg_trgm fuzzystrmatch btree_gin btree_gist].freeze

  def up
    EXTENSIONS.each do |ext|
      execute "CREATE EXTENSION IF NOT EXISTS #{ext}"
    end

    say_with_time('Adding support functions for pg_search :dmetaphone') do
      execute <<~SQL.squish
        CREATE OR REPLACE FUNCTION pg_search_dmetaphone(text) RETURNS text LANGUAGE SQL IMMUTABLE STRICT AS $function$
          SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
        $function$;
      SQL
    end
  end

  def down
    EXTENSIONS.each do |ext|
      execute "DROP EXTENSION IF EXISTS #{ext}"
    end

    say_with_time('Dropping support functions for pg_search :dmetaphone') do
      execute <<~SQL.squish
        DROP FUNCTION pg_search_dmetaphone(text);
      SQL
    end
  end
end
