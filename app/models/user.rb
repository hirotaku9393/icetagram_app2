class User < ApplicationRecord
    devise  :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    has_many :ice_creams, dependent: :destroy
    validates :name, presence: true, length: { minimum: 2 }
end
