require 'rails_helper'

RSpec.describe "Tag", type: :model do
    describe "バリデーションの検証" do
        it "nameがある場合バリデーションが通る" do
            tag = FactoryBot.build(:tag)
            expect(tag).to be_valid
        end

        it "nameがない場合バリデーションが通らない" do
            tag = FactoryBot.build(:tag, name: nil)
            expect(tag).to be_invalid
        end
    end
end
