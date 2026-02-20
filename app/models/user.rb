class User < ApplicationRecord
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :omniauthable, omniauth_providers: %i[line google_oauth2]
    has_many :ice_creams, dependent: :destroy
    has_many :charts, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :favorite_ice_creams, through: :favorites, source: :ice_cream
    validates :name, presence: true, length: { minimum: 2 }
    validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }



    def self.create_unique_string
        SecureRandom.uuid
    end

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

    def self.from_omniauth(auth)
        user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)

        user.assign_attributes(
            name: auth.info.name,
            email: auth.info.email || "#{auth.uid}-#{auth.provider}@example.com",
            image_url: auth.info.image
        )

        user.password ||= Devise.friendly_token[0, 20]
        user.save
        user
    end
end
