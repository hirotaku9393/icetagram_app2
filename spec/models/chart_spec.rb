require 'rails_helper'

RSpec.describe Chart, type: :model do
  let(:user) { create(:user) }
  let(:ice_cream) { create(:ice_cream) }
  

  describe 'バリデーション' do
    it 'sweetness, freshness, richness, calorie, ingredient_richness, chart_type, ice_cream_idがある場合バリデーションが通る' do
      chart = FactoryBot.build(:chart, user: user, ice_cream: ice_cream)
      expect(chart).to be_valid
    end

    it 'sweetnessがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, sweetness: nil)
      expect(chart).to be_invalid
    end

    it 'freshnessがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, freshness: nil)
      expect(chart).to be_invalid
    end

    it 'richnessがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, richness: nil)
      expect(chart).to be_invalid
    end

    it 'calorieがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, calorie: nil)
      expect(chart).to be_invalid
    end

    it 'ingredient_richnessがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, ingredient_richness: nil)
      expect(chart).to be_invalid
    end

    it 'chart_typeがない場合バリデーションが通らない' do
      chart = FactoryBot.build(:chart, chart_type: nil)
      expect(chart).to be_invalid
    end
  end
end
