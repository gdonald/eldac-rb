# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Page do
  subject(:page) { create(:page) }

  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_uniqueness_of(:url) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }
end
