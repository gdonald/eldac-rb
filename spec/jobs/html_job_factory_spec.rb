# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HtmlJobFactory do
  subject(:factory) { described_class.new }

  describe '#perform' do
    let!(:html) { create(:html) }

    it 'creates jobs with increasing delay' do
      allow(HtmlJob).to receive(:perform_in)
      factory.perform

      expect(HtmlJob).to have_received(:perform_in).with(0, html.id)
    end
  end
end
