class GoogleAuthService
  def initialize(user)
    @user = user
  end

  def token_expired?
    @user.google_access_token_expiry < Time.current
  end

  def refresh_access_token
    return unless token_expired?

    client = Signet::OAuth2::Client.new(
      client_id: ENV['google_oauth_client_id'],
      client_secret: ENV['google_oauth_client_secret'],
      token_credential_uri: 'https://oauth2.googleapis.com/token',
      refresh_token: @user.google_refresh_token
    )

    response = client.fetch_access_token!

    @user.update!(
      google_access_token: response['access_token'],
      google_access_token_expiry: Time.current + response['expires_in'].seconds
    )
  end
end
