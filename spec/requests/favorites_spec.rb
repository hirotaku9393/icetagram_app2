require 'rails_helper'

RSpec.describe "Favoritesコントローラーのテスト", type: :request do
    let!(:ice_cream) { FactoryBot.create(:ice_cream, user: user) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:favorite) { FactoryBot.create(:favorite, user: user, ice_cream: ice_cream) }
    describe "非ログイン時のfavoritesアクセス" do
        it "favoritesの作成を実行するとログインページにリダイレクトされること" do
            post favorites_path, params: { ice_cream_id: ice_cream.id }
            expect(response).to redirect_to new_user_session_path
        end
        it "favoritesの削除を実行するとログインページにリダイレクトされること" do
            delete favorite_path(favorite)
            expect(response).to redirect_to new_user_session_path
        end
    end
    describe "ログイン時のfavoritesアクセス" do
        before do
            sign_in user
        end
        it "favoritesの作成ができること" do
            new_ice_cream = FactoryBot.create(:ice_cream)
            expect {
                post favorites_path, params: { ice_cream_id: new_ice_cream.id }
            }.to change(Favorite, :count).by(1)
        end
        it "favoritesの削除ができること" do
            expect {
                delete favorite_path(favorite)
            }.to change(Favorite, :count).by(-1)
        end
    end
end
