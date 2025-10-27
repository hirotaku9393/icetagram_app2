Rails.application.config.session_store :cookie_store,
    key: '_icetagram_session',
    domain: :all,
    same_site: :lax,          
    secure: Rails.env.production?  
