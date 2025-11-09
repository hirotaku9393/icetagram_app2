class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token, only: [:create], if: :oauth_request?

    def build_resource(hash = {})
        hash[:uid] = User.create_unique_string
        super
    end

    def update_resource(resource, params)
        if resource.provider.present? # グーグル、ラインログインはパスワード不要
        resource.update_without_password(params)
        elsif params["password"].present?
        super
        else
        resource.update_without_password(params.except("current_password"))
        end
    end

    protected

    def oauth_request?
        request.path.include?('/auth/') || 
        params[:authenticity_token].blank? ||  
        request.referrer&.include?('/auth/')  
    end
end