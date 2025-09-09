class Admin < ApplicationRecord
    devise :database_authenticatable, :rememberable, :validatable
    def to_vector
        [sweetness, freshness, richness, texture, ingredient_richness].map(&:to_i)
    end
end 