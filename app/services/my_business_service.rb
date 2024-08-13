class MyBusinessService
  MyBusinessAccountManagement = Google::Apis::MybusinessaccountmanagementV1
  MyBusinessBusinessInformation = Google::Apis::MybusinessbusinessinformationV1

  def initialize(user)
    @user = user
    @account_service = MyBusinessAccountManagement::MyBusinessAccountManagementService.new
    @account_service.authorization = google_auth_client

    @business_service = MyBusinessBusinessInformation::MyBusinessBusinessInformationService.new
    @business_service.authorization = google_auth_client
  end

  def list_businesses
    refresh_access_token_if_needed
    account = list_account.first
    @business_service.list_locations("accounts/#{account.name}")
  end

  def get_reviews(business_name)
    refresh_access_token_if_needed
    @business_service.list_reviews(business_name)
  end

  private

  def list_account
    response = @account_service.list_accounts
    response.accounts
  end

  def google_auth_client
    Signet::OAuth2::Client.new(
      access_token: @user.google_access_token,
      refresh_token: @user.google_refresh_token,
      client_id: ENV['google_oauth_client_id'],
      client_secret: ENV['google_oauth_client_secret'],
      token_credential_uri: 'https://oauth2.googleapis.com/token'
    )
  end

  def refresh_access_token_if_needed
    if @user.google_access_token_expiry.present? && Time.current > @user.google_access_token_expiry
      refresh_access_token
    end
  end

  def refresh_access_token
    client = google_auth_client
    client.refresh!
    @user.update(
      google_access_token: client.access_token,
      google_refresh_token: client.refresh_token,
      google_access_token_expiry: Time.at(client.expires_at)
    )
  end
end
