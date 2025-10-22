class IceCreamsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:index, :show, :gotouchi]
  before_action :set_ice_cream, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
def index
  if params[:tag_id].present?
    @ice_creams = Tag.find(params[:tag_id]).ice_creams.page(params[:page]).per(10).order(created_at: :desc)
  else
    @ice_creams = IceCream.all.page(params[:page]).per(10).order(created_at: :desc)
  end
  @tags = Tag.limit(5)
end



  def new
    @ice_cream = IceCream.new
  end 

  def create
    # Ensure the current user is set before creating the ice cream
    @ice_cream = IceCream.new(ice_cream_params)
    @ice_cream.user = current_user
    tag_list = params[:ice_cream][:tag_ids].split(",")
    if @ice_cream.save
      Chart.create!(
        ice_cream: @ice_cream,
        sweetness: @ice_cream.sweetness,
        freshness: @ice_cream.freshness,
        richness: @ice_cream.richness, 
        calorie: @ice_cream.calorie,
        ingredient_richness: @ice_cream.ingredient_richness,
        chart_type: "user_post"
        )
      @ice_cream.save_tags(tag_list) if tag_list.present?
      redirect_to ice_creams_index_path, notice: "アイスクリームを登録しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update 
    if @ice_cream.update(ice_cream_params)
      redirect_to ice_cream_path(@ice_cream), notice: "アイスクリームを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @ice_cream.destroy
    redirect_to ice_creams_index_path, notice: "アイスクリームを削除しました。"
  end

  def show
    @chart = @ice_cream.chart
    @goods = RakutenWebService::Ichiba::Item.search(keyword: @ice_cream.name)
    @user = @ice_cream.user
  end

  def favorites
    @favorite_ice_creams = current_user.favorite_ice_creams.page(params[:page]).per(10).includes(:chart, :user).order(created_at: :desc)
  end

  def favorites
    @favorite_ice_creams = current_user.favorite_ice_creams.page(params[:page]).per(10).includes(:chart, :user).order(created_at: :desc)
  end

  def tags
    @tags = Tag.all
  end

  def gotouchi
    @ice_creams = IceCream.joins(:tags).where(tags: { name: "ご当地" }).page(params[:page]).per(10).order(created_at: :desc)
    @tags = Tag.limit(5)
    render :gotouchi
  end
  private
  def ice_cream_params
    params.require(:ice_cream).permit(:name, :image, :sweetness, :freshness, :richness, :calorie, :ingredient_richness, :comment, :arrange, :calorie_value) 
  end

  def set_ice_cream
    @ice_cream = IceCream.find(params[:id])
  end

  def authorize_user!
    unless @ice_cream.user == current_user
      redirect_to ice_creams_index_path, alert: "他のユーザーのアイスクリームは編集できません。"
    end
  end
end