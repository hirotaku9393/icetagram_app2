class TodayiceController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
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
    prepare_meta_tags
  end

  private
  
  def prepare_meta_tags
    image_url = "#{request.base_url}/images/ajigraf?text=#{CGI.escape(@today_ice.name)}"
    set_meta_tags og: {
                    title: "きょうのあいすは#{@today_ice.name}!",
                    description: "#{@today_ice.name}があなたにおすすめのアイスです！",
                    type: 'website',
                    url: request.original_url,
                    image: image_url
                  },
                  twitter: {
                    card: 'summary_large_image',
                    title: "きょうのあいすは#{@today_ice.name}!",
                    description: "#{@today_ice.name}があなたにおすすめのアイスです！",
                    image: image_url
                  }   
  end

end
