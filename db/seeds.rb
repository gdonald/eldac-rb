# frozen_string_literal: true

include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

create(:scheme)
create(:scheme, :https)
