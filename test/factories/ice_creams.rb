FactoryBot.define do
    factory :ice_cream do
        sequence(:name) { |n| "Ice Cream #{n}" }
        comment { "This is a test ice cream." }
        sweetness { 3 }
        freshness { 3 }
        richness { 3 }  
        calorie { 3 }
        ingredient_richness { 3 }
    end
end