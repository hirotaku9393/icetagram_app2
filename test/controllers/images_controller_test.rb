require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get ajigraf" do
    get new_ajigraf_path(text: "Test ")
    assert_response :success
  end
end
