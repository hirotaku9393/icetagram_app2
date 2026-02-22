class IceCreamsController < ApplicationController
  # deviseのauthenticate_user!を使用して、ユーザーがログインしていることを確認
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [ :index, :show, :gotouchi ]
  before_action :set_ice_cream, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]


  def index
    @q = IceCream.ransack(params[:q])

    preload_relations = [
      :tags,
      :user,
      :image_attachment
    ]

    if params[:q].present?
      @ice_creams = @q.result(distinct: true).includes(preload_relations)
    elsif params[:tag_id].present?
      tag = Tag.find_by(id: params[:tag_id])
      @ice_creams = tag.ice_creams.includes(preload_relations)
    else
      @ice_creams = IceCream.all.includes(preload_relations)
    end

    @ice_creams = @ice_creams.order(created_at: :desc).page(params[:page]).per(9)
    @tags = Tag.order("RANDOM()").limit(5)
  end


  def new
    @ice_cream = IceCream.new
  end

  def create
    # Ensure the current user is set before creating the ice cream
    @ice_cream = IceCream.new(ice_cream_params)
    @ice_cream.user = current_user
    tag_list = params[:ice_cream][:tag_ids]
              .split(/[,、\/]/)
              .map { |t| t.gsub(/[\s　]+/, "") }
              .reject(&:blank?)

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
      redirect_to ice_creams_path, notice: "アイスクリームを登録しました。"
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @tag_names = @ice_cream.tags.pluck(:name).join(", ")
  end

  def update
  # ネストされたparametersを扱い、タグ名を取得, tag_names はフォームで定義された名前
  tag_names = params[:ice_cream][:tag_names]
    # アイスクリームの情報を更新
    if @ice_cream.update(ice_cream_params)
      if tag_names.present?
        tag_list = tag_names.split(/[,、\/]/)
        .map { |t| t.gsub(/[\s　]+/, "") }  # 半角スペース + 全角スペース
        .reject(&:blank?) # カンマ、全角カンマ
        tags = tag_list.map { |name| Tag.find_or_create_by(name: name) } # tag_namesを配列にし、タグを見つけるor作成
        @ice_cream.tags = tags
      end
      if @ice_cream.chart.present?
        @ice_cream.chart.update(
          sweetness: @ice_cream.sweetness,
          freshness: @ice_cream.freshness,
          richness: @ice_cream.richness,
          calorie: @ice_cream.calorie,
          ingredient_richness: @ice_cream.ingredient_richness
        )
      end
      redirect_to @ice_cream, notice: "アイスを更新しました！"
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @ice_cream.destroy
    redirect_to ice_creams_path, notice: "アイスクリームを削除しました。"
  end

  def show
    @chart = @ice_cream.chart
    @user = @ice_cream.user
    original_name = @ice_cream.name
    search_word = fix_word(@ice_cream.name)

    if search_word.empty?
      @goods = []
    else
      begin
        @goods = RakutenWebService::Ichiba::Item.search(keyword: search_word)
      rescue => e
        Rails.logger.error "楽天APIエラー: #{e.message}"
        @goods = []
      end
    end
  end

  def favorites
    @favorite_ice_creams = current_user.favorite_ice_creams.page(params[:page]).per(10).includes(:image_attachment).order(created_at: :desc)
  end



  def tags
    @tags = Tag.all
  end

  def gotouchi
    @ice_creams = IceCream.joins(:tags).where(tags: { name: "ご当地" }).includes(:tags, :image_attachment).page(params[:page]).per(10).order(created_at: :desc)
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
      redirect_to ice_creams_path, alert: "他のユーザーのアイスクリームは編集できません。"
    end
  end

  # 正規表現1行目^以外の文字を削除、2行目は特殊文字削除、3行目は複数スペースを1スペースに、4行目は前後のスペース削除
  def fix_word(word)
    return "" if word.nil?
      word.to_s
      .strip
      .gsub(/[^\w\sぁ-んァ-ヶー一-龯]/, "")
      .gsub(/[！？＆＃＄％＾＊（）＋＝｜￥]/, "")
      .gsub(/\s+/, " ")
      .strip
  end
end
