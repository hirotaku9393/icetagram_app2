require 'rails_helper'

RSpec.describe "Topコントローラーテスト", type: :request do
    describe "トップページにアクセス" do
        before do
            get root_path
        end

        it "正しく表示されること" do
            expect(response).to have_http_status(:ok)
        end

        it "利用規約へのリンクがあること" do
            expect(response.body).to include("https://www.kiyac.app/termsOfService/ri6ZOLS05llljnE0Lqjp")
        end

        it "プライバシーポリシーへのリンクがあること" do
            expect(response.body).to include("https://www.kiyac.app/privacypolicy/DLDA7xVOvuaCKfLSyBLV")
        end
    end
end
