class SessionsController < Devise::SessionsController
  protected
    def after_sign_in_path_for(resource)
      URI(request.referer).path
    end
    def after_sign_out_path_for(resource)
      URI(request.referer).path
    end
end
