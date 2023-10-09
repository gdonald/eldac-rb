# frozen_string_literal: true

FactoryBot.define do
  factory :html do
    page

    content do
      <<~HTML.squish
        <h1>Title</h1>
        <p>Content</p>
        <a href="http://example.com">Link</a>
        <a href="/path">Relative</a>
        <a id="bookmark">ID</a>
      HTML
    end
  end
end
