class IceCream < ApplicationRecord
    has_one :chart, dependent: :destroy
    has_one_attached :image
    belongs_to :user, optional: true
    belongs_to :admin, optional: true
    def to_vector
        [sweetness, freshness, richness, texture, ingredient_richness].map(&:to_i)
    end
end
