require 'rubygems'
require 'spork'

# this is a hack to deal with some errant autoload behavior that was causing
# an "unable to autoload constant" error when running specs - we might be able
# to get rid of this in future versions
require File.expand_path("../../app/models/ucb_rails/ldap_person/finder", __FILE__)

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require "rails/application"
  require File.expand_path("../../dummy/config/environment", __FILE__)
  require 'rspec/rails'

  require 'database_cleaner'
  require 'capybara/rspec'

  require 'capybara/webkit'
  Capybara.javascript_driver = :webkit


  require 'coveralls'
  Coveralls.wear!

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
    config.filter_run focus: true
    config.order = "random"
    config.run_all_when_everything_filtered = true
    config.infer_spec_type_from_file_location!
    config.raise_errors_for_deprecations!

    config.before(:each) do
      DatabaseCleaner.strategy = :truncation #example.metadata[:js] ? :truncation : :transaction
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end
end

Spork.each_run do
  ActiveSupport::Dependencies.clear
end
