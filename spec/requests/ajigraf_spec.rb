require 'rails_helper'

RSpec.describe "ajigrafコントローラーのテスト", type: :request do
    let!(:ice_cream) { FactoryBot.create(:ice_cream) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:official_chart) { FactoryBot.create(:chart, ice_cream: ice_cream, chart_type: "official") }
    let!(:user_chart)     { FactoryBot.create(:chart, ice_cream: ice_cream, user: user, chart_type: "user_post") }

    describe "ajigrafにアクセス時" do
        it "ajigrafのトップページにアクセスできること" do
            get new_ajigraf_path
            expect(response).to have_http_status(:ok)
        end
    end

    describe "ajigrafの作成" do
        it "ajigrafが作成できること" do
            expect {
                post ajigraf_index_path, params: {
                    chart: { sweetness: 3, freshness: 4, richness: 5, calorie: 2, ingredient_richness: 4, ice_cream_id: ice_cream.id } } }.to change(Chart, :count).by(1)
            expect(response).to redirect_to result_ajigraf_index_path(chart_id: Chart.last.id)
        end
    end

    describe "ajigrafの結果表示" do
        it "ajigrafの結果ページにアクセスできること" do
            get result_ajigraf_index_path(chart_id: user_chart.id)
            expect(response).to have_http_status(:ok)
        end
    end
end
