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

    def result
        answers = (params[:answers] || {}).values
        score = 0

        QUIZZES.each_with_index do |quiz, i|
            score += 1 if answers[i] == quiz[:answer]
        end

        @score = score

        # スコア別メッセージ・画像・タイトル
        @message, og_image, title_message = case score
        when 0..3
            [ "残念！あいす初心者レベル…", "ochimusya.png", "まだまだこれから！" ]
        when 4..5
            [ "おお、なかなかのあいす通！", "asigaru.png", "伸びしろですねえ！" ]
        when 6..7
            [ "かなりのあいす好き！", "samurai.png", "頑張っています！" ]
        when 8..9
            [ "すごい！あいす将軍！", "syogun.png", "あいすの達人！" ]
        when 10
            [ "伝説のあいす大将軍！", "daisyogun.jpg", "あなたはあいす界の覇者です！" ]
        else
            [ "結果取得エラー", "icecream.png", "エラー" ]
        end

        @og_image = "#{request.base_url}/ogp/#{og_image}"
        @og_title = "IQテスト結果：#{score}/10（#{title_message}）"
        @og_description = @message
        @og_url = quizzes_url
        @comment = title_message
        prepare_meta_tags
    end

    def prepare_meta_tags
        set_meta_tags og: {
                        title: "#{@message}",
                        description: "#{@og_title}",
                        type: "website",
                        url: request.original_url,#現在アクセスしているページの完全なURL
                        image: "#{@og_image}"
                    },
                    twitter: {
                        card: "summary_large_image", #横長の大きい画像指定
                        title: "#{@message}",
                        description: "#{@og_title}",
                        image: "#{@og_image}"
                    }
    end
end
