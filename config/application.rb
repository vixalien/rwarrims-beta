require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rwarrims
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    ENV['VER'] = '0.25.0'
    config.load_defaults 5.2
    ENV['secret_key_base'] = 'b12a3d0dc0321c6b4685e71be483b19577b0d8dd707c58ca3fd878db67ccd4cf51e6f3cc4535a06b643cec1c04d133b320d0d9a0d20572b5d2bbff4930c221cc'
    Rails.application.config.action_dispatch.signed_cookie_digest = "SHA256"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
