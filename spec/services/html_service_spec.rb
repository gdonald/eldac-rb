# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HtmlService do
  subject(:service) { described_class.new(html) }

  let(:html) { create(:html, page:) }
  let(:page) { create(:page, blurb: nil, content: nil) }

  describe '#build!' do
    it 'sets the blurb' do
      expect { service.build! }.to change(page, :blurb).from(nil).to('Title')
    end

    it 'sets the content' do
      aggregate_failures do
        expect { service.build! }.to change(page, :content).from(nil).to('title content link relative')
        expect(Url.count).to eq(2)
        expect(Phrase.count).to eq(16)
      end
    end

    context 'when the url exists' do
      it 'does not create a new url' do
        service.build!
        expect { service.build! }.not_to change(Url, :count)
      end
    end

    context 'when the phrases exists' do
      it 'does not create new phrases' do
        service.build!
        expect { service.build! }.not_to change(Phrase, :count)
      end
    end
  end
end
