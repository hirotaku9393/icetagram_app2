require "test_helper"

class AjigrafControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get new_ajigraf_path
    assert_response :success
  end
end
