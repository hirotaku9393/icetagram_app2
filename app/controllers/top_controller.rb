class TopController < ApplicationController
  def index
    #user_signed_in?(deviseのメソッド）を使用して、ユーザーがログインしているか確認
    if user_signed_in?
      @chart = Chart.where(user_id: current_user.id).last
      if @chart.present?
        user_vec = @chart.to_vector
        charts_for_ice = Chart.where(chart_type: [ :official, :user_post ]).includes(:ice_cream).where.not(ice_cream_id: nil)
        sorted_charts = charts_for_ice.sort_by { |c| euclidean_distance(user_vec, c.to_vector) }
        #drop(1)を使い、一度おすすめされたアイスクリームを除外、それ以外のアイスを3件取得
        @top_3_charts = sorted_charts.uniq { |c| c.ice_cream_id }.drop(1).first(3)
        #絞りこんだチャートからアイスクリームを取得し、画像も一緒に読み込む
        @recomend  = @top_3_charts.map(&:ice_cream)
        @recomend_ice = IceCream.where(id: @recomend.map(&:id)).includes(:image_attachment)
      end
    end
  end
  private
  def euclidean_distance(vector1, vector2)
    Math.sqrt(vector1.zip(vector2).map { |a, b| (a - b) ** 2 }.sum)
  end
end
