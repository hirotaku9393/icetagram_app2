
FactoryBot.define do
    factory :tag do
        name { "もちもち" }
        after(:create) do |tag|
        create(:ice_cream_relationship, tag: tag, ice_cream: create(:ice_cream) )
        end
    end
end
