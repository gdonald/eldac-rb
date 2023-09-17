# frozen_string_literal: true

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

create(:scheme)
create(:scheme, :https)

create(:host_rule, name: 'gregdonald.com')

create(:url, value: 'http://gregdonald.com')
create(:url, value: 'https://gregdonald.com')
create(:url, value: 'https://gregdonald.com/')
create(:url, value: 'https://gregdonald.com/path')
create(:url, value: 'https://gregdonald.com/path/foo')
create(:url, value: 'https://gregdonald.com/path?foo=bar')
create(:url, value: 'https://gregdonald.com/path?foo=bar#baz')
create(:url, value: 'h')
create(:url, value: 'http')
create(:url, value: 'https')
create(:url, value: 'https:')
create(:url, value: 'https:/')
create(:url, value: 'https://')
create(:url, value: 'https://example')
create(:url, value: 'https://example.com')
