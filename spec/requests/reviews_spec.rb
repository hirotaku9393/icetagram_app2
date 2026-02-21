require 'rails_helper'

RSpec.describe "Reviewsコントローラーのテスト", type: :request do
    let!(:user) { FactoryBot.create(:user) }
    let!(:other_user) { FactoryBot.create(:user) }
    let!(:ice_cream) { FactoryBot.create(:ice_cream, user: user) }

    describe "非ログイン時のreviewsアクセス" do
        it "感想の作成を実行するとログインページにリダイレクトされること" do
            post ice_cream_reviews_path(ice_cream), params: { review: { content: "おいしい" } }
            expect(response).to redirect_to new_user_session_path
        end

        it "感想の削除を実行するとログインページにリダイレクトされること" do
            review = FactoryBot.create(:review, user: user, ice_cream: ice_cream)
            delete ice_cream_review_path(ice_cream, review)
            expect(response).to redirect_to new_user_session_path
        end
    end

    describe "ログイン時のreviewsアクセス" do
        before { sign_in user }

        describe "感想の作成" do
            it "有効なcontentで感想を作成できること" do
                expect {
                    post ice_cream_reviews_path(ice_cream), params: { review: { content: "とてもおいしい！" } }
                }.to change(Review, :count).by(1)
            end

            it "作成後はアイスクリーム詳細ページにリダイレクトされること" do
                post ice_cream_reviews_path(ice_cream), params: { review: { content: "とてもおいしい！" } }
                expect(response).to redirect_to ice_cream_path(ice_cream)
            end

            it "contentが空の場合は感想が作成されないこと" do
                expect {
                    post ice_cream_reviews_path(ice_cream), params: { review: { content: "" } }
                }.not_to change(Review, :count)
            end
        end

        describe "感想の削除" do
            let!(:review) { FactoryBot.create(:review, user: user, ice_cream: ice_cream) }

            it "自分の感想を削除できること" do
                expect {
                    delete ice_cream_review_path(ice_cream, review)
                }.to change(Review, :count).by(-1)
            end

            it "削除後はアイスクリーム詳細ページにリダイレクトされること" do
                delete ice_cream_review_path(ice_cream, review)
                expect(response).to redirect_to ice_cream_path(ice_cream)
            end

            it "他のユーザーの感想は削除できないこと" do
                other_review = FactoryBot.create(:review, user: other_user, ice_cream: ice_cream)
                expect {
                    delete ice_cream_review_path(ice_cream, other_review)
                }.not_to change(Review, :count)
            end
        end
    end
end
