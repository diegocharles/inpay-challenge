# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

require 'factory_bot_rails'
require 'faker'
require 'rails_helper'
require 'rspec-rails'
require 'shoulda/matchers'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'

  config.include FactoryBot::Syntax::Methods
  config.include Rack::Test::Methods
  config.include FactoryBot::Syntax::Methods

  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
