FactoryBot.define do
    factory :favorite do
        association :user
        association :ice_cream
    end
end
