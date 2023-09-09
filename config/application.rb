# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eldac
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.active_job.queue_adapter = :good_job
    config.good_job = {
      preserve_job_records: true,
      retry_on_unhandled_error: false,
      on_thread_error: ->(exception) { Raven.capture_exception(exception) },
      execution_mode: :async,
      queues: '*',
      max_threads: 5,
      poll_interval: 30,
      shutdown_timeout: 25,
      enable_cron: true,
      cron: {
        crawl_job: {
          cron: '* * * * *',
          class: 'CrawlSchedulerJob',
          args: [],
          kwargs: {},
          set: {},
          description: 'Schedule crawling of pages'
        }
      }
    }

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.active_record.schema_format = :sql
  end
end
