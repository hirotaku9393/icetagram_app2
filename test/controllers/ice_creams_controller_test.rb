require "test_helper"

class IceCreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get minnano_osi_index_url
    assert_response :success
  end
end
