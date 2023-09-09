# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HostRule do
  subject(:host_rule) { create(:host_rule) }

  it { is_expected.to be_valid }
end
