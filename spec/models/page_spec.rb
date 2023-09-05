# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page do
  subject(:page) { create(:page) }

  it { is_expected.to belong_to(:query) }
  it { is_expected.to have_many(:page_crawls).dependent(:destroy) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
  it { is_expected.to validate_length_of(:content).is_at_most((2**18) - 1) }
end
