# frozen_string_literal: true

class PageView < ApplicationRecord
  belongs_to :page

  def self.ransackable_attributes(_auth_object = nil)
    %w[page_id scheme_name host_name path_value query_value url]
  end
end
