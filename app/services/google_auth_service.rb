class GoogleAuthService
  def initialize(user)
    @user = user
  end

  def refresh_access_token
    return unless token_expired?

    uri = URI.parse('https://oauth2.googleapis.com/token')
    response = Net::HTTP.post_form(uri, {
      'client_id' => ENV['google_oauth_client_id'],
      'client_secret' => ENV['google_oauth_client_secret'],
      'refresh_token' => @user.google_refresh_token,
      'grant_type' => 'refresh_token'
    })

    if response.is_a?(Net::HTTPSuccess)
      token_data = JSON.parse(response.body)
      update_user_token(token_data)
    else
      Rails.logger.error("Failed to refresh Google access token: #{response.body}")
    end
  end

  private

  def token_expired?
    return true if @user.google_access_token_expiry.nil?
    @user.google_access_token_expiry < Time.current
  end

  def update_user_token(token_data)
    @user.update(
      google_access_token: token_data['access_token'],
      google_access_token_expiry: Time.current + token_data['expires_in'].seconds
    )
  end
end
