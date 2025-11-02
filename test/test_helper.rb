
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
    include FactoryBot::Syntax::Methods  # facory_botを使う
    parallelize(workers: :number_of_processors)
    
end

class ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    include FactoryBot::Syntax::Methods  # facory_botを使う
end

class ActionController::TestCase
    include Devise::Test::ControllerHelpers
    include FactoryBot::Syntax::Methods # facory_botを使う
end