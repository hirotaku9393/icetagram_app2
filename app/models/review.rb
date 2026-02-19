class Review < ApplicationRecord
  belongs_to :user
  # ポリモーフィック関連付け
  belongs_to :ice_cream, optional: true
  validates :content, presence: true, length: { maximum: 100 }
end
