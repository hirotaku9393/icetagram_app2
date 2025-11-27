class TodayIce < ApplicationRecord
  belongs_to :ice_cream
  before_create :set_uuid

  private
  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
