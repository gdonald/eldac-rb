# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageView do
  it { is_expected.to belong_to(:page) }

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[page_id scheme_name host_name path_value query_value url]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end
end
