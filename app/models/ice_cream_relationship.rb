class IceCreamRelationship < ApplicationRecord
  belongs_to :ice_cream
  belongs_to :tag
  validates :ice_cream_id, uniqueness: { scope: :tag_id }
end
