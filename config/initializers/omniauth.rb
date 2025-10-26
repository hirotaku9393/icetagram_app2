
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
            ENV['GOOGLE_CLIENT_ID'],
            ENV['GOOGLE_CLIENT_SECRET'],
            {
                scope: 'email,profile',
                redirect_uri: "https://#{ENV.fetch('APP_HOST', 'www.icetagram.com')}/auth/google_oauth2/callback"
            }
end
