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
        # OAuthプロバイダーへのリクエストかどうかを判定
        Rails.logger.debug "=== OAuth Request Check ==="
        Rails.logger.debug "Request path: #{request.path}"
        Rails.logger.debug "Request method: #{request.method}"
        Rails.logger.debug "Parameters: #{params.inspect}"
        Rails.logger.debug "Referrer: #{request.referrer}"
        
        # 1. リクエストパスがOmniauthのものかチェック
        omniauth_path = request.path.include?('/auth/')
        
        # 2. パラメータにプロバイダー情報があるかチェック  
        provider_param = params[:provider].present?
        
        # 3. リファラーがOAuthページからのものかチェック
        referrer_oauth = request.referrer&.include?('/auth/')
        
        # 4. パラメータが空（OAuthリクエストの特徴）
        empty_params = params.keys.size <= 3 # controller, action, authenticity_token のみ
        
        result = omniauth_path || provider_param || referrer_oauth || empty_params
        
        Rails.logger.debug "OAuth request result: #{result}"
        Rails.logger.debug "=========================="
        
        result
    end
end