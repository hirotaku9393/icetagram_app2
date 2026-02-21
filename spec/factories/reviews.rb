FactoryBot.define do
  factory :review do
    content { "MyText" }
    association :user
    association :ice_cream
  end
end
