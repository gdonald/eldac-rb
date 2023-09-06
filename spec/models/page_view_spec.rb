# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageView do
  it { is_expected.to belong_to(:page) }
end
