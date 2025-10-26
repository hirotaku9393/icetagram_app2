Rails.application.config.session_store :cookie_store,
    key: '_icetagram_session',
    domain: 'icetagram.com',
    same_site: :lax,          
    secure: Rails.env.production?  
