class Api::IceCreamsController < ApplicationController
    include Rails.application.routes.url_helpers

    def index
        ice_creams = IceCream
        .where.not(calorie_value: nil)
        .with_attached_image

        render json: ice_creams.map { |ice|
        {
            id: ice.id,
            name: ice.name,
            calorie_value: ice.calorie_value,
            image_url: ice.image.attached? ? url_for(ice.image) : nil
        }
        }
    end
end
