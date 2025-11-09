class Users::RegistrationsController < Devise::RegistrationsController
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
end
