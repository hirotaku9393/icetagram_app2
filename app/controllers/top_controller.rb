class TopController < ApplicationController
  def index
    @chart = Chart.where(user_id: current_user.id).last
    if @chart.present?
      user_vec = @chart.to_vector
      charts_for_ice = Chart.where(chart_type: [:official, :user_post]).includes(:ice_cream).where.not(ice_cream_id: nil)
      sorted_charts = charts_for_ice.sort_by { |c| euclidean_distance(user_vec, c.to_vector) }
      @top_3_charts = sorted_charts.uniq { |c| c.ice_cream_id }.drop(1).first(3)
      @recomend_ice   = @top_3_charts.map(&:ice_cream )
    end
  end
  private
  def euclidean_distance(vector1, vector2)
    Math.sqrt(vector1.zip(vector2).map { |a, b| (a - b) ** 2 }.sum)
  end
end
