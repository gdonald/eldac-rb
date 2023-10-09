# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlJobFactory do
  subject(:factory) { described_class.new }

  describe '#perform' do
    let!(:url) { create(:url) }

    it 'creates jobs with increasing delay' do
      allow(UrlJob).to receive(:perform_in)
      factory.perform

      expect(UrlJob).to have_received(:perform_in).with(0, url.id)
    end
  end
end
