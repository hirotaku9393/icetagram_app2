class AjigrafController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  def index
  end
  def new
    @chart = Chart.new
    @ice_creams = IceCream.all
  end

  def create
    # user_signed_in?のときはcurrent_user.idを、そうでないときはnilを設定
    user_id = user_signed_in? ? current_user.id : nil
    # 受け取ったchart_paramsにchart_type: "user", user_id: user_idをマージ（追加）する
    @chart = Chart.new(chart_params.merge(chart_type: "user", user_id: user_id))
    if @chart.save
      redirect_to result_ajigraf_index_path(chart_id: @chart.id)
    else
      render :new
    end
  end

  def result
    @chart = Chart.find(params[:chart_id])
    # ice_creamモデルに定義されたto_vectorメソッドを使用して、チャートを数値化
    user_vec = @chart.to_vector

    charts_for_ice = Chart.where(chart_type: [ :official, :user_post ]).includes(ice_cream: [ :image_attachment ]).where.not(ice_cream_id: nil)

    closest_chart = charts_for_ice.min_by { |c| euclidean_distance(user_vec, c.to_vector) }
    @closest_chart = closest_chart
    @closest_ice   = closest_chart&.ice_cream

    if @closest_ice.nil?
      redirect_to new_ajigraf_path, alert: "おすすめのアイスが見つかりませんでした。もう一度試してください。"
      return
    end

    prepare_meta_tags
  end

  private

  def chart_params
    params.require(:chart).permit(:sweetness, :freshness, :richness, :calorie, :ingredient_richness, :ice_cream_id)
  end

  def euclidean_distance(vector1, vector2)
    # ユークリッド距離を計算
    Math.sqrt(vector1.zip(vector2).map { |a, b| (a - b) ** 2 }.sum)
  end


  def prepare_meta_tags
    # CGI.escapeメソッドを使用して、アイスクリームの名前をURLエンコード(urlで文字列は使用できない)
    image_url = "#{request.base_url}/images/ajigraf?text=#{CGI.escape(@closest_ice.name)}"
    # set_meta_tagsメソッドを使用して、OGPとTwitterカードのメタタグを設定
    set_meta_tags og: {
                    title: "あなたにピッタリなアイスは#{@closest_ice.name}!",
                    description: "#{@closest_ice.name}があなたにおすすめのアイスです！",
                    type: "website",
                    url: request.original_url,
                    image: image_url
                  },
                  twitter: {
                    card: "summary_large_image",
                    title: "あなたにピッタリなアイスは#{@closest_ice.name}!",
                    description: "#{@closest_ice.name}があなたにおすすめのアイスです！",
                    image: image_url
                  }
  end
end
