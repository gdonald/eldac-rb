# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url do
  subject(:url) { create(:url) }

  describe 'aasm' do
    let(:url) { described_class.new }

    it { is_expected.to have_state(:created) }
    it { is_expected.to transition_from(:created).to(:running).on_event(:run) }
    it { is_expected.to transition_from(:running).to(:completed).on_event(:complete) }
    it { is_expected.to transition_from(:running).to(:failed).on_event(:fail) }
  end

  describe '.ransackable_attributes' do
    it 'returns an array of attributes' do
      expected = %w[aasm_state created_at error id updated_at value]
      expect(described_class.ransackable_attributes).to match_array(expected)
    end
  end
end
