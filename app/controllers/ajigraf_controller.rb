class AjigrafController < ApplicationController
  def index
  end
  def new
    @chart = Chart.new
    @ice_creams = IceCream.all
  end

  def create
    @chart = Chart.new(chart_params.merge(chart_type: 'user'))
    if @chart.save
      redirect_to result_ajigraf_index_path(chart_id: @chart.id)
    else 
      render :new
    end
  end

  def result 
    @chart = Chart.find(params[:chart_id])
    user_vec = @chart.to_vector

    charts_for_ice = Chart.where(chart_type: [:official, :user_post]).includes(:ice_cream).where.not(ice_cream_id: nil)

    closest_chart = charts_for_ice.min_by { |c| euclidean_distance(user_vec, c.to_vector) }
    @closest_chart = closest_chart
    @closest_ice   = closest_chart&.ice_cream
    @ogp_image_url = generate_ogp_image if @closest_ice&.image&.attached?
  end

  private

  def chart_params
    params.require(:chart).permit(:sweetness, :freshness, :richness, :calorie, :ingredient_richness, :ice_cream_id)
  end

  def euclidean_distance(vector1, vector2)
    Math.sqrt(vector1.zip(vector2).map { |a, b| (a - b) ** 2 }.sum)
  end

  def generate_ogp_image
    generator = OgpImageGenerator.new(ice_cream: @closest_ice)
    generator.generate
  end
end
