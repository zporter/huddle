ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# so Devise plays nicely with our functional tests
include Devise::TestHelpers
# allows the use of dom_id method in tests
include ActionController::RecordIdentifier

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # sign in as a user
  def login_as_one
    sign_in(users(:one))    
  end
  
  def set_current_project(symbol)
    @request.session[:project_id] = projects(symbol).id
  end
end
