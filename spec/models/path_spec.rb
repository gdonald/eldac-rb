# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Path do
  subject { create(:path) }

  it { is_expected.to belong_to(:host) }
  it { is_expected.to have_many(:queries).dependent(:destroy) }
  it { is_expected.to validate_length_of(:value).is_at_most(1023) }
  it { is_expected.to validate_presence_of(:value) }
end
