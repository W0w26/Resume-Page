class ApplicationController < ActionController::Base
  before_action :check_timeout

  private

  def check_timeout
    last_seen_at = session[:last_seen_at]
    if last_seen_at
      last_seen_at = Time.parse(last_seen_at) rescue nil
      if last_seen_at && Time.current - last_seen_at > 1.hour
        reset_session
        redirect_to new_user_session_path, alert: "Your session has expired. Please log in again."
      end
    end
    session[:last_seen_at] = Time.current.iso8601
  end
end
