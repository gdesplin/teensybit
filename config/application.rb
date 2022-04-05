require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Teensybit
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoload_paths += Dir[
      "#{config.root}/lib/**/",
      "#{config.root}/validators/"
    ]
    config.active_job.queue_adapter = :sidekiq
    config.active_record.schema_format = :sql
    config.generators do |g|
      g.assets false
      g.controller_specs false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
      g.helper false
      g.routing_specs false
      g.test_framework :rspec, fixture: true
      g.view_specs false
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
