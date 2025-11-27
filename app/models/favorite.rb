class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :ice_cream
  validates :user_id, uniqueness: { scope: :ice_cream_id }
end
