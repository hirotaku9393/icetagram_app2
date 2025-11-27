require "line/bot"
class LinebotController < ApplicationController
    # callbackアクションのCSRFトークン認証を無効
    protect_from_forgery except: [ :callback ]

    # 署名検証を行う
    def client
        @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
    end

    def callback
        # lineが送ってきたリクエストの中身
        body = request.body.read

        signature = request.env["HTTP_X_LINE_SIGNATURE"]
        # 改ざんされていないかチェック
        unless client.validate_signature(body, signature)
        head :bad_request
        return
        end

        events = client.parse_events_from(body)
        # １つのリクエストには複数のイベントの可能性、eachで回す
        # LINEのイベント情報から userId を取り出しアプリ側の User モデルで該当ユーザーを検索
        events.each { |event|
        user_id = event["source"]["userId"]
        user = User.where(uid: user_id)[0]
        if event.message["text"].include?("今日のアイス")
            message = today_ice(send_today_ice(user))
        else
            message = test_selenium(user)
        end

        case event
        # メッセージが送信された場合
        when Line::Bot::Event::Message
            case event.type
            # メッセージが送られて来た場合
            when Line::Bot::Event::MessageType::Text
            client.reply_message(event["replyToken"], message)
            end
        end
        }

        head :ok
    end

    private

    def send_today_ice(user)
        today_ice = IceCream.order("RANDOM()").first
        name = today_ice.name
        response = "きょうのおすすめあいすは#{name}!"
        response
    end

    def today_ice(response) # #メッセージの形式を作成
        {
        type: "flex",
        altText: "今日のアイス",
        contents: {
            type: "bubble",
            header: {
            type: "box",
            layout: "horizontal",
            contents: [
                {
                type: "text",
                text: "今日のアイス",
                wrap: true,
                size: "md"
                }
            ]
            },
            body: {
            type: "box",
            layout: "horizontal",
            contents: [
                {
                type: "text",
                text: response,
                wrap: true,
                size: "sm"
                }
            ]
            }
        }
        }
    end
end
