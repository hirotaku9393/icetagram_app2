class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :ice_cream
  # user_idとice_cream_idの組み合わせが一意であることを検証
  validates :user_id, uniqueness: { scope: :ice_cream_id }
end
