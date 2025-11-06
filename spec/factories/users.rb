FactoryBot.define do
    factory :user do
        sequence(:name) { |n| "Test User #{n}" }
        sequence(:email) { |n| "test#{n}#{Time.current.to_i}@example.com" }
        password { "password123456789" }
        password_confirmation { "password123456789" }
        provider { nil } # 明示的nilにする
        uid { nil }
    end
end