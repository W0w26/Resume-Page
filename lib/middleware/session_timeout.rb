class SessionTimeout
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    last_seen_at = request.session[:last_seen_at]

    if last_seen_at
      last_seen_at = Time.parse(last_seen_at) rescue nil
      if last_seen_at && Time.current - last_seen_at > 1.hour
        request.session.clear
        return [302, { 'Location' => '/users/sign_in' }, []]
      end
    end

    request.session[:last_seen_at] = Time.current.iso8601
    @app.call(env)
  end
end
