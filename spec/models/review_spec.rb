require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "バリデーションの検証" do
    it "contentがある場合バリデーションが通る" do
      review = FactoryBot.build(:review)
      expect(review).to be_valid
    end

    it "contentがない場合バリデーションが通らない" do
      review = FactoryBot.build(:review, content: nil)
      expect(review).to be_invalid
    end

    it "userがない場合バリデーションが通らない" do
      review = FactoryBot.build(:review, user: nil)
      expect(review).to be_invalid
    end

    it "ice_creamがない場合バリデーションが通らない" do
      review = FactoryBot.build(:review, ice_cream: nil)
      expect(review).to be_invalid
    end
  end
end
