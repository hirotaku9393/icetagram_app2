class QuizzesController < ApplicationController
    QUIZZES = [
        {
            question: "ピノを製造しているメーカーは？",
            options: [ "明治製菓", "森永乳業", "ロッテ" ],
            answer: "森永乳業"
        },
        {
            question: "あずきバーを製造しているメーカーは？",
            options: [ "井村屋", "赤城乳業", "丸永製菓" ],
            answer: "井村屋"
        },
        {
            question: "2024年もっとも売れたアイスは?",
            options: [
            "明治 エッセル スーパーカップ超バニラ",
            "パピコ チョココーヒー",
            "チョコモナカジャンボ"
            ],
            answer: "チョコモナカジャンボ"
        },
        {
            question: "ロッテの「雪見だいふく」が初めて発売された季節は？",
            options: [ "夏", "秋", "冬" ],
            answer: "秋"
        },
        {
            question: "コーンにアイスを乗せて売る“アイスクリームコーン”が大流行したきっかけは？",
            options: [ "世界博覧会", "冬の寒波", "カルロス・コーン伯爵が好んで食べていた" ],
            answer: "世界博覧会"
        },
        {
            question: "アイスキャンディー（棒アイス）が偶然誕生したとされるのは？",
            options: [
            "子どもがジュースを外に置き忘れて凍った",
            "アイスクリーム工場での作業員のミス",
            "冷蔵庫に入れるはずのものを間違えて冷凍庫に入れた"
            ],
            answer: "子どもがジュースを外に置き忘れて凍った"
        },
        {
            question: "ソフトクリームが世界で初めて大規模に提供されたイベントは？",
            options: [ "第一回近代オリンピック", "パリ万博", "ニューヨーク万国博覧会" ],
            answer: "ニューヨーク万国博覧会"
        },
        {
            question: "日本に最初にアイスクリームが登場したのはいつ？",
            options: [ "江戸時代", "明治時代", "大正時代" ],
            answer: "明治時代"
        },
        {
            question: "日本で初めてアイスが市販された場所は？",
            options: [ "横浜", "大阪", "札幌" ],
            answer: "横浜"
        },
        {
            question: "icetagramの開発者が一番好きなガリガリ君の味は？",
            options: [ "梨", "ソーダ", "コーラ" ],
            answer: "コーラ"
        }
    ]

    def index
        @quizzes = QUIZZES
    end


    def check
        answers = (params[:answers] || {}).values
        score = 0

        QUIZZES.each_with_index do |quiz, x|
        score += 1 if answers[x] == quiz[:answer]
        end

        redirect_to result_quizzes_path(score: score)
    end


    def result
        score = params[:score].to_i

        @score = score

        @message, og_image, title_message = case score
        when 0..3
        [
            "おぬし、まだ“あいすの地獄”をさまよう落ち武者よ…。これから修行を積めば、きっとあいすの極意に近づけるぞ！",
            "ochimusya.png",
            "伸びしろ無限大じゃ！"
        ]
        when 4..5
        [
            "なかなかやるのう、あいす足軽！一歩ずつ甘味の道を駆け上がっておる。さらなる精進で上を目指すのじゃ！",
            "asigaru.png",
            "まだまだ修行が必要じゃ！"
        ]
        when 6..7
        [
            "見事！おぬし、甘味の心得ある“あいす侍”よ。鋭い舌と確かな経験が光っておるぞ！",
            "samurai.png",
            "いざ、将軍へ駆け上がれ！"
        ]
        when 8..9
        [
            "おお…見事なり！おぬしあいすを治める“あいす将軍”。その洞察力はまさに天下統一級じゃ！",
            "syogun.png",
            "あいすの覇権は近い！"
        ]
        when 10
        [
            "伝説降臨！おぬしこそ“あいす大将軍”。甘味のすべてを知り尽くした究極の存在よ…！その名、永遠に語り継がれん。",
            "daisyogun.png",
            "あいす界の絶対王者！"
        ]
        else
        [ "結果取得エラー", "icecream.png", "エラー" ]
        end


        @og_image = "#{request.base_url}/ogp/#{og_image}"
        @og_title = "#{score}/10：#{title_message}"
        @og_description = @message
        @og_url = request.original_url
        @title_message =  title_message

        prepare_meta_tags
    end

    def prepare_meta_tags
        set_meta_tags og: {
                        title: @og_title,
                        description: @og_description,
                        type: "website",
                        url: @og_url,
                        image: @og_image
                        },
                        twitter: {
                        card: "summary_large_image",
                        title: @og_title,
                        description: @og_description,
                        image: @og_image
                        }
    end
end
