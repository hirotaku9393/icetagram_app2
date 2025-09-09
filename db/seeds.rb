# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(
    name: "Kazuta",
    email: "kazuta@example.com",
    password: "password123",
    password_confirmation: "password123"
)

IceCream.create!(
    name: "あずきバー",
    comment: "冬でもガリガリ食べたくなる和風の名作！",
    arrange: "ぜんざいに入れると最高",
    user: user
)

IceCream.create!(
    name: "サクレレモン",
    comment: "レモンの酸味が爽やか！夏にぴったりの一品。",
    arrange: "レモン果汁を絞るとさらに酸っぱくなっておいしい",
    user: user
)

IceCream.create!(
    name: "ガリガリ君ソーダ",
    comment: "夏の定番！シャリシャリの食感がたまらない。",
    arrange: "ソーダ割りでさらに爽快感アップ",
    user: user
)

IceCream.create!(
    name: "チョコモナカジャンボ",
    comment: "チョコとモナカの絶妙なコンビネーション！",
    arrange: "モナカの皮をトーストして、サクサク感をアップ",
    user: user
)

IceCream.create!(
    name: "ピノ",
    comment: "小さな一口サイズのアイスクリーム。いろんな味が楽しめるのが魅力！",
    arrange: "ピノを溶かして、温かいチョコレートソースをかけるとデザート感アップ",
    user: user
)

IceCream.create!(
    name: "parm",
    comment: "クリーミーなアイスクリームとしっとりチョコレートのハーモニー！",
    arrange: "温めたパルム  をトーストして、外側のチョコレートをパリッとさせると美味しい",
    user: user
)

Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "あずきバー").id,
    sweetness: 3,
    freshness: 3,
    richness: 3,
    calorie: 3,
    ingredient_richness: 4,
    chart_type: "official"
)
Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "サクレレモン").id,
    sweetness: 4,
    freshness: 5,
    richness: 2,
    calorie: 2,
    ingredient_richness: 4,
    chart_type: "official"
)

Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "ガリガリ君ソーダ").id,
    sweetness: 4,   
    freshness: 5,
    richness: 2,
    calorie: 1,
    ingredient_richness: 2,
    chart_type: "official"
)
Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "チョコモナカジャンボ").id,
    sweetness: 4,
    freshness: 1,
    richness: 3,
    calorie: 5,
    ingredient_richness: 2,
    chart_type: "official"
)
Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "ピノ").id,           
    sweetness: 5,
    freshness: 2,
    richness: 4,
    calorie: 3,
    ingredient_richness: 2,
    chart_type: "official"
)
Chart.create!(
    ice_cream_id: IceCream.find_by!(name: "parm").id,
    sweetness: 4,
    freshness: 2,
    richness: 5,
    calorie: 3,
    ingredient_richness: 3,
    chart_type: "official"
)
