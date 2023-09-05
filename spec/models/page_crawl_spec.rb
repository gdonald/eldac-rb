# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PageCrawl do
  subject(:page_crawl) { create(:page_crawl) }

  it { is_expected.to belong_to(:page) }

  describe 'aasm' do
    let(:page_crawl) { described_class.new }

    it { is_expected.to have_state(:created) }
    it { is_expected.to transition_from(:created).to(:running).on_event(:run) }
    it { is_expected.to transition_from(:running).to(:completed).on_event(:complete) }
    it { is_expected.to transition_from(:running).to(:failed).on_event(:fail) }
  end
end
