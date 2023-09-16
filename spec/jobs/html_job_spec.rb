# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HtmlJob do
  subject(:html_job) { described_class.new(service_klass) }

  let(:service_klass) { HtmlService }
  let(:service) { instance_double(HtmlService) }
  let(:html) { create(:html) }

  before do
    allow(service_klass).to receive(:new).and_return(service)
  end

  describe '#perform' do
    it 'saves the html' do
      allow(service).to receive(:build!).and_return(true)
      html_job.perform(html.id)
      expect(html.reload).to be_completed
    end

    context 'with a failure' do
      before do
        allow(service).to receive(:build!).and_raise(StandardError, 'error')
        html_job.perform(html.id)
        html.reload
      end

      it 'fails the html' do
        expect(html).to be_failed
      end

      it 'saves an error' do
        expect(html.error).to eq('error')
      end
    end
  end
end
