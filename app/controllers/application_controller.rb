class ApplicationController < ActionController::Base
    helper ApplicationHelper
    # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    allow_browser versions: :modern
    before_action :configure_permitted_parameters, if: :devise_controller?

    protect_from_forgery with: :exception
    
    # Configure additional parameters for Devise
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    def set_ogp_tags(title:, description:, image_url:)
        set_meta_tags(
            title: title,
            description: description,
            og: {
                title: title,
                description: description,
                type: 'website',
                url: request.original_url,
                image: image_url
            },
            twitter: {
                card: 'summary_large_image',
                title: title,
                description: description,
                image: image_url
            }
        )
    end
end
