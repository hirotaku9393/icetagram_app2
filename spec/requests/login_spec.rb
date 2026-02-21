require "rails_helper"

RSpec.describe "ログイン機能のテスト", type: :request do
    let(:user) { FactoryBot.create(:user) }

    describe "ログインページ" do
        it "ログインページにアクセスできること" do
            get new_user_session_path
            expect(response).to have_http_status(:ok)
        end
    end

    describe "ログイン処理" do
        it "正しい認証情報でログインできること" do
            post user_session_path, params: {
                user: { email: user.email, password: user.password }
            }
            expect(response).to redirect_to root_path
        end

        it "間違ったパスワードではログインできないこと" do
            post user_session_path, params: {
                user: { email: user.email, password: "wrongpassword" }
            }
            expect(response).to have_http_status(:unprocessable_content)
        end
    end

    describe "ログアウト処理" do
        before { sign_in user }
        it "ログアウトできること" do
            delete destroy_user_session_path
            expect(response).to redirect_to root_path
        end
    end

    describe "ログインが必要なページ" do
        it "未ログインで投稿ページにアクセスするとログインページにリダイレクトされること" do
            get new_ice_cream_path
            expect(response).to redirect_to new_user_session_path
        end
    end
end
