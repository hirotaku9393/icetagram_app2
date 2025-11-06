require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリエーションの検証' do
    it 'バリエーションが通る' do
      expect(build(:user)).to be_valid
    end

    it '名前がなければ無効であること' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it 'メールアドレスがなければ無効であること' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it 'パスワードがなければ無効であること' do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end
  end
end
