class FavoritesController < ApplicationController
  def create
    ice_cream = IceCream.find(params[:ice_cream_id])
    current_user.favorite(ice_cream)
    redirect_to ice_cream_path(ice_cream), notice: "#{ice_cream.name}を食べてみたい‼に追加しました"
  end

  def destroy
    ice_cream = current_user.favorites.find(params[:id]).ice_cream
    current_user.unfavorite(ice_cream)
    redirect_to ice_cream_path(ice_cream), notice: "#{ice_cream.name}を食べてみたい!から削除しました"
  end
end
