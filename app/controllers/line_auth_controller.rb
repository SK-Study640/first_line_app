class LineAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :callback ]

  def callback
    auth = request.env["omniauth.auth"]  # LINEからの認証情報を取得
    user = User.find_or_initialize_by(uid: auth["uid"], provider: auth["provider"])
    user.name = auth["info"]["name"]
    user.line_user_id = auth["uid"]
    user.provider = auth["provider"]
    # LINEから画像URLを取得してローカルに保存
    if auth["info"]["image"].present?
      begin
        image_file = URI.open(auth["info"]["image"]) # LINEの画像URLから取得
        user.profile_image.attach(io: image_file, filename: "profile_#{user.id}.jpg", content_type: "image/jpeg")
      rescue => e
        Rails.logger.error "プロフィール画像取得エラー: #{e.message}"
      end
    else
      # LINEから画像URLが取得できない場合はデフォルト画像を設定
      user.profile_image.attach(io: File.open(Rails.root.join("app/assets/images/default_profile.png")), filename: "default.jpg", content_type: "image/jpeg")
    end
    user.save!
    # ユーザーをログイン状態にする
    session[:user_id] = user.id
    redirect_to new_registrations_path
  end

  def failure
    Rails.logger.error "LINE認証エラー: #{e.message}"
    redirect_to root_path, alert: "LINE認証に失敗しました"
  end
end
