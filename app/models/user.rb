class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[6,10]
      user.google_access_token = auth.credentials.token
      user.google_refresh_token = auth.credentials.refresh_token if auth.credentials.refresh_token.present?
      user.google_access_token_expiry = Time.now + 1.hour
      user.save!
      user
    end
  end
end
