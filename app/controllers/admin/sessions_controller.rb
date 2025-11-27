# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
    layout "admin"

    def new
      super
    end
    def create
      self.resource = warden.authenticate!(auth_options)
    end
    def after_sign_out_path_for(resource)
      new_admin_session_path
    end
end
