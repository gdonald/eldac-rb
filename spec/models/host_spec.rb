# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Host do
  subject(:host) { create(:host) }

  it { is_expected.to belong_to(:scheme) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(255) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:scheme_id).case_insensitive }
end
