# frozen_string_literal: true

json.pages @pages do |page|
  json.title page.title
  json.url page.url
  json.blurb page.blurb
  json.url page.url
end
json.next_page @pages.respond_to?(:next_page) ? path_to_next_page(@pages) : nil
