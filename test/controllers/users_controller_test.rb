require "test_helper"
# deviseのユーザコントローラのテスト(通常ログインではなく)

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get sinup" do
    get new_user_registration_path
    assert_response :success
  end

  test "should get signin" do
    get new_user_session_path
    assert_response :success
  end
end
