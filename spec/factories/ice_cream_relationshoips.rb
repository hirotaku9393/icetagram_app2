FactoryBot.define do
    factory :ice_cream_relationship do
        association :ice_cream
        association :tag
    end
end
