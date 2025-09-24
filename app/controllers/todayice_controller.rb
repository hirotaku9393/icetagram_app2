class TodayiceController < ApplicationController
  def index
  end

  def result
    @today_ice = IceCream.order("RANDOM()").first
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
