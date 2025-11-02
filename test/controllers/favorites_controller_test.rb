require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @ice_cream = create(:ice_cream)
  end

  test "should create favorite" do
    #sign_in(@user)
    assert_difference('Favorite.count') do
      post favorites_create_path(@ice_cream)
    end
    assert_response :redirect
  end

  test "should destroy favorite" do
    #sign_in(@user)
    favorite = create(:favorite, user: @user, ice_cream: @ice_cream)
    assert_difference('Favorite.count', -1) do
      delete favorites_destroy_path(@ice_cream, favorite)
    end
    assert_response :redirect
  end
end
