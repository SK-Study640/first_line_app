Rails.application.config.middleware.use OmniAuth::Builder do
  provider :line, ENV["LINE_CHANNEL_ID"], ENV["LINE_CHANNEL_SECRET"], {
    callback_url: "https://yourdomain.com/auth/line/callback",
    scope: "profile openid",
    bot_prompt: "normal"
  }
end
