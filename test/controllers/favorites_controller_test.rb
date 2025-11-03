require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @ice_cream = create(:ice_cream)
  end

  test "should redirect to login when not authenticated for create" do
    assert_no_difference 'Favorite.count' do
      post favorites_path, params: { ice_cream_id: @ice_cream.id }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login when not authenticated for destroy" do
    favorite = create(:favorite, user: @user, ice_cream: @ice_cream)
    
    assert_no_difference 'Favorite.count' do
      delete favorite_path(favorite)
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end
end