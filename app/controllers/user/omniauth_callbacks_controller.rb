class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    Rails.logger.debug("OmniAuth auth: #{auth.inspect}")
    Rails.logger.debug("Parameters: #{params.inspect}")

    if auth
      user = User.from_omniauth(auth)

      if user.present? && user.persisted?
        sign_out_all_scopes
        flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
        sign_in_and_redirect user, event: :authentication
        flash[:notice] = "Your password is #{user.password}"
      else
        flash[:alert] = t "devise.omniauth_callbacks.failure", kind: 'Google', reason: "#{auth.info.email} is not authorized or already existing."
        redirect_to new_user_session_path
      end
    else
      Rails.logger.debug("OmniAuth auth is nil")
      redirect_to new_user_session_path, alert: 'Authentication error'
    end
  end

  private

  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
