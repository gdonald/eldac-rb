# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlJob do
  subject(:url_job) { described_class.new(service_klass) }

  let(:service_klass) { UrlService }
  let(:service) { instance_double(UrlService) }
  let(:url) { create(:url) }

  before do
    allow(service_klass).to receive(:new).and_return(service)
  end

  describe '#perform' do
    it 'saves the url' do
      allow(service).to receive(:save!).and_return(true)
      url_job.perform(url.id)
      expect(url.reload).to be_completed
    end

    context 'with a failure' do
      before do
        allow(service).to receive(:save!).and_raise(StandardError, 'error')
        url_job.perform(url.id)
        url.reload
      end

      it 'fails the url' do
        aggregate_failures do
          expect(url).to be_failed
          expect(url.error).to eq('error')
        end
      end
    end

    context 'with a bad url id' do
      it 'does not run' do
        allow(service_klass).to receive(:new)
        url_job.perform(0)
        expect(service_klass).not_to have_received(:new)
      end
    end
  end
end
