# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

require 'support/factory_girl'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include RSpec::DefaultHttpHeader
  config.include RSpec::JsonMatcher

  config.before :example, type: :request, json: true do
    default_headers['CONTENT_TYPE'] = 'application/json'
    default_headers['ACCEPT'] = 'application/json'
  end
end
