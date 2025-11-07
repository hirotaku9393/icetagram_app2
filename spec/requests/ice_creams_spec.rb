require 'rails_helper'

RSpec.describe "ice_creamsコントローラーのテスト", type: :request do
    let!(:ice_cream) { FactoryBot.create(:ice_cream, user: user) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:favorite) { FactoryBot.create(:favorite, user: user, ice_cream: ice_cream) }
    let!(:chart) { FactoryBot.create(:chart, ice_cream: ice_cream, chart_type: "user_post") }
    describe "非ログイン時のice_creamsアクセス" do
        before do
            allow(RakutenWebService::Ichiba::Item).to receive(:search).and_return([])
        end
        it "ice_creamsのトップページにアクセスできること" do
            get ice_creams_path
            expect(response).to have_http_status(:ok)
        end
        it "ice_creamsの詳細ページにアクセスできること" do
            get ice_cream_path(ice_cream)
            expect(response).to have_http_status(:ok)
        end
        it "ice_creamsの検索結果ページにアクセスできること" do
            get ice_creams_path, params: { q: { name_cont: "アイス" } }
            expect(response).to have_http_status(:ok)
        end
        it "投稿ページにアクセスするとログインページにリダイレクトされること" do
            get new_ice_cream_path
            expect(response).to redirect_to new_user_session_path
        end
        it "編集ページにアクセスするとログインページにリダイレクトされること" do
            get edit_ice_cream_path(ice_cream)
            expect(response).to redirect_to new_user_session_path
        end
        it "削除を実行するとログインページにリダイレクトされること" do
            delete ice_cream_path(ice_cream)
            expect(response).to redirect_to new_user_session_path
        end
    end
    describe "ログイン時のice_creamsアクセス" do
        before do
            allow(RakutenWebService::Ichiba::Item).to receive(:search).and_return([])
            sign_in user
        end
        it "ice_creamsのトップページにアクセスできること" do
            get ice_creams_path
            expect(response).to have_http_status(:ok)
        end
        it "ice_creamsの詳細ページにアクセスできること" do
            get ice_cream_path(ice_cream)
            expect(response).to have_http_status(:ok)
        end
        it "ice_creamsの検索結果ページにアクセスできること" do
            get ice_creams_path, params: { q: { name_cont: "アイス" } }
            expect(response).to have_http_status(:ok)
        end
        it "投稿ページにアクセスできること" do
            get new_ice_cream_path
            expect(response).to have_http_status(:ok)
        end
        it "投稿時、アイスの登録ができること" do
            expect {
                post ice_creams_path, params: {
                ice_cream: {
                        name: "新しいアイス",
                        comment: "テストアイス",
                        sweetness: 3,
                        freshness: 4,
                        richness: 5,
                        calorie: 2,
                        ingredient_richness: 4,
                        tag_ids: "",
                        user_id: user.id } } }.to change(IceCream, :count).by(1)
            expect(response).to redirect_to ice_creams_index_path
        end
        it "投稿時、アイスの名前がないと登録ができないこと" do
            expect {
                post ice_creams_path, params: {
                ice_cream: {
                        name: "",
                        comment: "テストアイス",
                        sweetness: 3,
                        freshness: 4,
                        richness: 5,
                        calorie: 2,
                        ingredient_richness: 4,
                        tag_ids: "",
                        user_id: user.id } } }.to change(IceCream, :count).by(0)
        end
        it "編集ページにアクセスできること" do
            get edit_ice_cream_path(ice_cream)
            expect(response).to have_http_status(:ok)
        end
        it "編集時、アイスの更新ができること" do
            patch ice_cream_path(ice_cream), params: {
                ice_cream: {
                    name: "更新したアイス",
                    comment: ice_cream.comment,
                    sweetness: ice_cream.sweetness,
                    freshness: ice_cream.freshness,
                    richness: ice_cream.richness,
                    calorie: ice_cream.calorie,
                    ingredient_richness: ice_cream.ingredient_richness,
                    user_id: user.id } }
            expect(response).to redirect_to ice_cream_path(ice_cream)
            ice_cream.reload
            expect(ice_cream.name).to eq "更新したアイス"
        end
        it "編集時、アイスの名前がないと更新ができないこと" do
            patch ice_cream_path(ice_cream), params: {
                ice_cream: {
                    name: "",
                    comment: ice_cream.comment,
                    sweetness: ice_cream.sweetness,
                    freshness: ice_cream.freshness,
                    richness: ice_cream.richness,
                    calorie: ice_cream.calorie,
                    ingredient_richness: ice_cream.ingredient_richness,
                    user_id: user.id } }
            expect(response).to have_http_status(:unprocessable_entity)
        end
        it "削除時、アイスの削除ができ、アイスの件数がへること" do
            expect { delete ice_cream_path(ice_cream) }.to change(IceCream, :count).by(-1)
        end
        it "削除を実行するとアイスクリーム一覧ページにリダイレクトされること" do
            delete ice_cream_path(ice_cream)
            expect(response).to redirect_to ice_creams_index_path
        end

        it "他人のアイス編集ページにアクセスすると一覧ページにリダイレクトされること" do
            other_user = FactoryBot.create(:user)
            other_ice_cream = FactoryBot.create(:ice_cream, user: other_user)
            get edit_ice_cream_path(other_ice_cream)
            expect(response).to redirect_to ice_creams_index_path
        end
        it "他人のアイスを削除実行すると一覧ページにリダイレクトされること" do
            other_user = FactoryBot.create(:user)
            other_ice_cream = FactoryBot.create(:ice_cream, user: other_user)
            delete ice_cream_path(other_ice_cream)
            expect(response).to redirect_to ice_creams_index_path
        end
        it "タグでの絞り込みができること" do
            tag = FactoryBot.create(:tag)
            get ice_creams_path, params: { tag_id: tag.id }
            expect(response).to have_http_status(:ok)
        end
    end
end
