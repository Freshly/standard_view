# frozen_string_literal: true

require "spec_helper"
require "simplecov"
require "rails"
require "spicerack/spec_helper"

SimpleCov.start do
  add_filter "/spec/"
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment", __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

require "standard_view"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers

  config.filter_rails_from_backtrace!
end
