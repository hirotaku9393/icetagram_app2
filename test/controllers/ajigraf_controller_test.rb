require "test_helper"

class AjigrafControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ajigraf_index_url
    assert_response :success
  end
end
