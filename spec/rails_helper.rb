# frozen_string_literal: true

require "spec_helper"
require "simplecov"
require "rails"
require "spicerack/spec_helper"
require "rspec"

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/config/"
end

ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment", __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require "rspec-html-matchers"

require "standard_view"

require "support/test_classes/user"
require "support/test_classes/order"
require "support/test_classes/user_material"
require "support/test_classes/order_material"
require "support/test_classes/test_facet"
require "support/test_classes/test"

require "support/helpers/fake_law_helper"

require "support/shared_context/with_example_materials"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.include Rails.application.routes.url_helpers

  config.filter_rails_from_backtrace!
end
