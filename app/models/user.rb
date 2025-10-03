class User < ApplicationRecord
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    has_many :ice_creams, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_ice_creams, through: :favorites, source: :ice_cream
    validates :name, presence: true, length: { minimum: 2 }

    def favorite(ice_cream)
        favorite_ice_creams << ice_cream
    end

    def unfavorite(ice_cream)
        favorite_ice_creams.delete(ice_cream)
    end

    def favorite?(ice_cream)
        favorite_ice_creams.include?(ice_cream)
    end

    def own?(object)
        id == object.user_id
    end

end
