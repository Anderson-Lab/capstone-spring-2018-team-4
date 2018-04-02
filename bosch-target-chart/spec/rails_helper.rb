# Define test environment
ENV["RAILS_ENV"] ||= 'test'

# Require Rails environment file
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'devise'
require "paperclip/matchers"

# Require any support files (these typically handle gem imports)
Dir[Rails.root.join('spec/support/**/*.rb')].each{ |file| require file }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Rails.application.routes.url_helpers
  config.include Paperclip::Shoulda::Matchers
  config.extend ControllerMacros, type: :controller
end
