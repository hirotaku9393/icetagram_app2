require 'rails_helper'

RSpec.describe "Quizzesコントローラーのテスト", type: :request do
    describe "クイズ一覧ページ" do
        it "クイズ一覧ページにアクセスできること" do
            get quizzes_path
            expect(response).to have_http_status(:ok)
        end

        it "ログインなしでもアクセスできること" do
            get quizzes_path
            expect(response).to have_http_status(:ok)
        end
    end

    describe "クイズの採点" do
        context "全問正解の場kui合" do
            it "スコア10でresultページにリダイレクトされること" do
                correct_answers = {
                    "0" => "森永乳業",
                    "1" => "井村屋",
                    "2" => "チョコモナカジャンボ",
                    "3" => "秋",
                    "4" => "世界博覧会",
                    "5" => "子どもがジュースを外に置き忘れて凍った",
                    "6" => "ニューヨーク万国博覧会",
                    "7" => "明治時代",
                    "8" => "横浜",
                    "9" => "コーラ"
                }
                post check_quizzes_path, params: { answers: correct_answers }
                expect(response).to redirect_to result_quizzes_path(score: 10)
            end
        end

        context "全問不正解の場合" do
            it "スコア0でresultページにリダイレクトされること" do
                post check_quizzes_path, params: { answers: {} }
                expect(response).to redirect_to result_quizzes_path(score: 0)
            end
        end

        context "回答なしの場合" do
            it "スコア0でresultページにリダイレクトされること" do
                post check_quizzes_path
                expect(response).to redirect_to result_quizzes_path(score: 0)
            end
        end
    end

    describe "クイズの結果表示" do
        it "結果ページにアクセスできること" do
            get result_quizzes_path(score: 5)
            expect(response).to have_http_status(:ok)
        end

        it "スコア0〜3で落ち武者のメッセージが表示されること" do
            get result_quizzes_path(score: 0)
            expect(response.body).to include("伸びしろ無限大じゃ！")
        end

        it "スコア4〜5で足軽のメッセージが表示されること" do
            get result_quizzes_path(score: 4)
            expect(response.body).to include("まだまだ修行が必要じゃ！")
        end

        it "スコア6〜7で侍のメッセージが表示されること" do
            get result_quizzes_path(score: 6)
            expect(response.body).to include("いざ、将軍へ駆け上がれ！")
        end

        it "スコア8〜9で将軍のメッセージが表示されること" do
            get result_quizzes_path(score: 8)
            expect(response.body).to include("あいすの覇権は近い！")
        end

        it "スコア10で大将軍のメッセージが表示されること" do
            get result_quizzes_path(score: 10)
            expect(response.body).to include("あいすの覇者じゃ！")
        end
    end
end
