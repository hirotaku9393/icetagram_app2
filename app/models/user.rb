class User < ApplicationRecord
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable,
            :omniauthable, omniauth_providers: %i[line]
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

    #ユーザーが複数のsns連携を持っている場合("line")のようにすることで、そのサービスのプロフィールを返す
    def social_profile(provider)
        social_profiles.select { |sp| sp.provider == provider.to_s }.first
    end

    #userの属性を変更するメソッド
    def set_values(omniauth)
        return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
        credentials = omniauth["credentials"]
        info = omniauth["info"]

        access_token = credentials["refresh_token"]
        access_secret = credentials["secret"]
        credentials = credentials.to_json
        name = info["name"]
    end
        
    #JSONに変換して保存する
    def set_values_by_raw_info(raw_info)
        self.raw_info = raw_info.to_json
        self.save!
    end

end
