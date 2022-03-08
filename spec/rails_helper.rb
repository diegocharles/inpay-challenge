# frozen_string_literal: true
require 'simplecov'
require 'simplecov-console'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.include ActionCable::TestHelper
  config.include Rails.application.routes.url_helpers, type: :api
  
  config.filter_run_excluding broken: true
end

SimpleCov.minimum_coverage 70
formatters = [SimpleCov::Formatter::Console]
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(formatters)

SimpleCov::Formatter::Console.show_covered = true

SimpleCov.start do
  add_filter '/spec/'
end
