Rails.application.config.session_store :cookie_store, key: '_myapp_session', secure: Rails.env.production?
Rails.application.config.session_store :cookie_store, key: '_your_app_session', expire_after: 1.hour
