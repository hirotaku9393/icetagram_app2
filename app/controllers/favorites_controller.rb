class FavoritesController < ApplicationController
  # deviseが提供するauthenticate_user!を使用して、ユーザーがログインしていることを確認
  before_action :authenticate_user!
  def create
    ice_cream = IceCream.find(params[:ice_cream_id])
    current_user.favorite(ice_cream)
    redirect_to ice_creams_path, notice: "#{ice_cream.name}を食べてみたい‼に追加しました"
  end

  def destroy
    ice_cream = current_user.favorites.find(params[:id]).ice_cream
    current_user.unfavorite(ice_cream)
    redirect_to ice_creams_path, notice: "#{ice_cream.name}を食べてみたい!から削除しました"
  end
end
