# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:valid_relationship) { create(:relationship, :valid_relationship) }
  let!(:owner) { create(:relationship, :owner) }

  describe 'valid relationship' do
    it 'has a valid factory' do
      expect(valid_relationship).to be_valid
    end

    it 'can be an owner' do
      expect(described_class.owner.name).to eq('owner')
    end
  end
end
