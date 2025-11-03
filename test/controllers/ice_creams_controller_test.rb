require "test_helper"

class IceCreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ice_creams_index_path
    assert_response :success
  end
end
