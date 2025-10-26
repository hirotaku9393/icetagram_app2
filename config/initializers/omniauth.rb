
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2,
            ENV['GOOGLE_CLIENT_ID'],
            ENV['GOOGLE_CLIENT_SECRET'],
            {
                scope: 'email,profile',
                prompt: 'select_account',
                redirect_uri: ENV.fetch('GOOGLE_REDIRECT_URI', nil)
            }
end
