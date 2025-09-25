class TodayiceController < ApplicationController
  def index
  end

  def result
    if params[:uuid].present?
      today_ice_record = TodayIce.find_by(uuid: params[:uuid])
      @today_ice = today_ice_record&.ice_cream
      @today_ice_uuid = today_ice_record.uuid
    else
      ice = IceCream.order("RANDOM()").first
      today_ice = TodayIce.create(ice_cream: ice)
      @today_ice = ice
      @today_ice_uuid = today_ice.uuid
    end
    
    @chart = @today_ice.chart
    @ogp_image_url = generate_ogp_image

    set_ogp_tags(
    title: "きょうのあいすは#{@today_ice.name}!",
    description: "#{@today_ice.name}があなたにおすすめのアイスです！",
    image_url: request.base_url + @ogp_image_url
    )
  end

  private 
  def generate_ogp_image
    generator = TodayiceOgpGenerator.new(ice_cream: @today_ice)
    generator.generate
  end
end
