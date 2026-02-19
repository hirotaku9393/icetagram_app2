class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  def ajigraf
    text = ogp_params[:text]
    image = AjigrafCreator.build(text).tempfile.open.read
    send_data image, type: "image/png", disposition: "inline"
  end

  def todayice
    text = ogp_params[:text]
    image = TodayIcefCreator.build(text).tempfile.open.read
    send_data image, type: "image/png", disposition: "inline"
  end

  private

  def ogp_params
    # Strong Parametersを使用して、urlパラメータから:textを許可
    params.permit(:text)
  end
end
