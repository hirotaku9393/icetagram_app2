require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションの検証' do
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
  describe 'アソシエーションの検証' do
    it 'ice_creamsと1:Nの関係であること' do
      expect(User.reflect_on_association(:ice_creams).macro).to eq :has_many
    end

    it 'favoritesと1:Nの関係であること' do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end
    it 'chartsと1:Nの関係であること' do
      expect(User.reflect_on_association(:charts).macro).to eq :has_many
    end
  end
end
