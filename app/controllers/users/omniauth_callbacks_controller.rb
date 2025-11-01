module Users
    class OmniauthCallbacksController < Devise::OmniauthCallbacksController
        skip_before_action :verify_authenticity_token, only: :google_oauth2

        def google_oauth2
            callback_for(:google)
        end
        def line
            basic_action
        end

        def failure
            redirect_to new_user_session_path, alert: "認証に失敗しました。"
        end

        private
        def callback_for(provider)
            @user = User.from_omniauth(request.env["omniauth.auth"])

            if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: provider.to_s.capitalize) if is_navigational_format?
            else
            flash[:alert] = @user.errors.full_messages.to_sentence if @user.errors.any?
            session["devise.#{provider}_data"] = request.env["omniauth.auth"].except(:extra)
            redirect_to new_user_registration_url
            end
        end

        def basic_action
            @omniauth = request.env["omniauth.auth"]
            if @omniauth.present?
            @profile = User.find_or_initialize_by(provider: @omniauth["provider"], uid: @omniauth["uid"])
            if @profile.email.blank?
                email = @omniauth["info"]["email"] ? @omniauth["info"]["email"] : "#{@omniauth["uid"]}-#{@omniauth["provider"]}@example.com"
                @profile = current_user || User.create!(provider: @omniauth["provider"], uid: @omniauth["uid"], email: email, name: @omniauth["info"]["name"], password: Devise.friendly_token[0, 20])
            end
            @profile.set_values(@omniauth)
            sign_in(:user, @profile)
            end
            # ログイン後のflash messageとリダイレクト先を設定
            flash[:notice] = "ログインしました"
            redirect_to root_path
        end



        def fake_email(uid, provider)
            "#{auth.uid}-#{auth.provider}@example.com"
        end
    end
end
