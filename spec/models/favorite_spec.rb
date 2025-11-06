require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:user) { create(:user) }
  let(:ice_cream) { create(:ice_cream) }
  
  describe 'バリデーション' do
    it 'user_id,ice_cream_idがある場合バリデーションが通る' do
      favorite = FactoryBot.build(:favorite, user: user, ice_cream: ice_cream)
      expect(favorite).to be_valid
    end

    it 'user_idがない場合バリデーションが通らない' do
      favorite = FactoryBot.build(:favorite, user: nil)
      expect(favorite).to be_invalid
    end

    it 'ice_cream_idがない場合バリデーションが通らない' do
      favorite = FactoryBot.build(:favorite, ice_cream: nil)
      expect(favorite).to be_invalid
    end
  end
end
