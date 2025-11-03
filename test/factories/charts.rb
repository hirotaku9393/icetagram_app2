FactoryBot.define do
    factory :chart do
        sweetness { 3 }
        freshness { 3 }
        richness { 3 }
        calorie { 3 }
        ingredient_richness { 3 }
        chart_type { "user" }
        association :ice_cream           # ← 自動でice_creamを作成
        association :user               # ← 自動でuserを作成
    end
end
