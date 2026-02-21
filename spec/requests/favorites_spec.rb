require 'rails_helper'

RSpec.describe "Favoritesコントローラーのテスト", type: :request do
    let!(:ice_cream) { FactoryBot.create(:ice_cream, user: user) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:favorite) { FactoryBot.create(:favorite, user: user, ice_cream: ice_cream) }
    describe "非ログイン時のfavoritesアクセス" do
        it "favoritesの作成を実行するとログインページにリダイレクトされること" do
            post ice_cream_favorites_path(ice_cream)
            expect(response).to redirect_to new_user_session_path
        end
        it "favoritesの削除を実行するとログインページにリダイレクトされること" do
            delete ice_cream_favorite_path(ice_cream, favorite)
            expect(response).to redirect_to new_user_session_path
        end
    end
    describe "ログイン時のfavoritesアクセス" do
        before do
            sign_in user
        end
        it "favoritesの作成ができること" do
            expect {
                post ice_cream_favorites_path(ice_cream)
            }.to change(Favorite, :count).by(1)
        end
        it "favoritesの削除ができること" do
            expect {
                delete ice_cream_favorite_path(ice_cream, favorite)
            }.to change(Favorite, :count).by(-1)
        end
    end
end