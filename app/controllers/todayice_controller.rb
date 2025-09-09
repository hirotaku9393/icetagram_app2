class TodayiceController < ApplicationController
  def index
  end

  def result
    @today_ice = IceCream.order("RANDOM()").first
    @chart = @today_ice.chart
  end
end
