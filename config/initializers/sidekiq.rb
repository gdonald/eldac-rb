# frozen_string_literal: true

cron_file = 'config/sidekiq.yml'

if File.exist?(cron_file) && Sidekiq.server?
  cron = YAML.load_file(cron_file)
  Sidekiq::Cron::Job.load_from_hash(cron)
end
