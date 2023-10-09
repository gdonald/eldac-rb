# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer do
  describe 'default from' do
    it 'is set to the default' do
      expect(described_class.default[:from]).to eq('from@example.com')
    end
  end
end
