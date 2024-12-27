Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [ :post, :get ] # GETリクエストを許可
  OmniAuth.config.silence_get_warning = true             # GETの警告を無効化

  provider :line, ENV["LINE_CHANNEL_ID"], ENV["LINE_CHANNEL_SECRET"], {
    callback_url: "http://127.0.0.1:3000/auth/line/callback",
    scope: "profile openid",
    bot_prompt: "normal",
    provider_ignores_state: true # state パラメータ を無視
  }
end
