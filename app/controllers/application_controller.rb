class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  # Configure additional parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def serve_ogp_image
    file_path = Rails.root.join('tmp', 'ogp_ajigraf_images', params[:path])
    
    if File.exist?(file_path)
      send_file file_path, type: 'image/png', disposition: 'inline'
    else
      head :not_found
    end
  end

end
