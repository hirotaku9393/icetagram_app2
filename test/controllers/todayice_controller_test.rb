require "test_helper"

class TodayiceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get todayice_index_url
    assert_response :success
  end
end
