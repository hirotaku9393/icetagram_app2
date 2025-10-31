class IceCream < ApplicationRecord
    has_one :chart, dependent: :destroy
    has_one_attached :image
    belongs_to :user, optional: true
    belongs_to :admin, optional: true
    has_many :favorites, dependent: :destroy
    has_many :ice_cream_relationships, dependent: :destroy
    has_many :tags, through: :ice_cream_relationships
    def to_vector
        [sweetness, freshness, richness, texture, ingredient_richness].map(&:to_i)
    end

    def save_tags(saveice_cream_tags)
        saveice_cream_tags.each do |new_name|
            ice_cream_tag = Tag.find_or_create_by(name: new_name)
            self.tags << ice_cream_tag
        end
    end

    def self.ransackable_attributes(auth_object = nil)
        %w[name comment]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[tags user]
    end

end
