require 'rails_helper'

RSpec.describe IceCream, type: :model do
  describe 'バリデーションの検証' do
    it 'アイスの名前がある場合バリデーションが通る' do
      ice_cream = FactoryBot.build(:ice_cream)
      expect(ice_cream).to be_valid
    end

    it 'アイスの名前がない場合にバリデーションエラー' do
      ice_cream = FactoryBot.build(:ice_cream, name: nil)
      expect(ice_cream).to be_invalid
    end
  end
end
