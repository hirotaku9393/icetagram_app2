require 'rails_helper'

RSpec.describe "today_iceコントローラーのテスト", type: :request do
    let!(:ice_cream) { FactoryBot.create(:ice_cream) }
    let!(:chart) do
        ice_cream.create_chart!(
        sweetness: 3,
        freshness: 4,
        richness: 5,
        calorie: 2,
        ingredient_richness: 4,
        chart_type: "user_post"
        )
    end
    let!(:today_ice) { FactoryBot.create(:today_ice, ice_cream: ice_cream) }

    describe "非ログイン時のtoday_iceアクセス" do
        it "today_iceのトップページにアクセスできること" do
        get todayice_index_path
        expect(response).to have_http_status(:ok)
        end

        it "today_iceの結果ページにアクセスできること" do
        # ここで uuid パラメータを渡して、コントローラ内でランダムではなくテスト用 ice_cream を使う
        get result_todayice_index_path(uuid: today_ice.uuid)
        expect(response).to have_http_status(:ok)
        end
    end

    describe "ログイン時のtoday_iceアクセス" do
        let!(:user) { FactoryBot.create(:user) }

        before do
        sign_in user
        end

        it "today_iceのトップページにアクセスできること" do
        get todayice_index_path
        expect(response).to have_http_status(:ok)
        end

        it "today_iceの結果ページにアクセスできること" do
        get result_todayice_index_path(uuid: today_ice.uuid)
        expect(response).to have_http_status(:ok)
        end
    end
end
