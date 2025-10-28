Rails.application.config.session_store :cookie_store,
    key: '_icetagram_session',
    domain: Rails.env.production? ? 'icetagram.com' : nil,
    same_site: :lax,
    secure: Rails.env.production? ,
    httponly: true 
