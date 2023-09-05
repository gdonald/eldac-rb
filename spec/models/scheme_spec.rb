# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scheme do
  subject(:scheme) { create(:scheme) }

  it { is_expected.to have_many(:hosts).dependent(:destroy) }
  it { is_expected.to validate_length_of(:name).is_at_most(8) }
  it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  it { is_expected.to validate_presence_of(:name) }
end
