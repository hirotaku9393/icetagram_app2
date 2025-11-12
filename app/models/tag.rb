class Tag < ApplicationRecord
    has_many :ice_cream_relationships, dependent: :destroy
    has_many :ice_creams, through: :ice_cream_relationships, dependent: :destroy
    validates :name, presence: true, uniqueness: true
end
