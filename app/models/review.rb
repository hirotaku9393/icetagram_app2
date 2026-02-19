class Review < ApplicationRecord
  belongs_to :user
  #ポリモーフィック関連付け
  belongs_to :ice_cream, optional: true
end
