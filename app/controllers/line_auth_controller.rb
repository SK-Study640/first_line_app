class LineAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :callback ]
  TMP_USER_IMAGE_PATH = "app/assets/images"

  def callback
    auth = request.env["omniauth.auth"]  # LINEからの認証情報を取得
    @user = User.find_or_initialize_by(uid: auth["uid"], provider: auth["provider"])
    @user.name = auth["info"]["name"]
    @user.line_user_id = auth["uid"]
    @user.provider = auth["provider"]
    @user.tmp_profile_file_path = image(auth, @user.line_user_id)
    redirect_to new_registrations_path(name: @user.name, line_user_id: @user.line_user_id, provider: @user.provider, tmp_profile_file_path: @user.tmp_profile_file_path)
  end

  def image(auth, line_user_id)
    # LINEから画像URLを取得して一時ファイルとして保存
    if auth["info"]["image"].present?
      begin
        image_file = URI.open(auth["info"]["image"]) # LINEの画像URLから取得
      rescue => e
        Rails.logger.error "プロフィール画像取得エラー: #{e.message}"
      end
    else
        # LINEから画像URLが取得できない場合はデフォルト画像を設定
        image_file = File.open(Rails.root.join("app/assets/images/default_profile.png"))
    end
    file_path = Rails.root.join(TMP_USER_IMAGE_PATH, "#{line_user_id}.jpg")
    File.open(file_path, "wb") { |f| f.write(image_file) }
    file_path
  end

  def failure
    Rails.logger.error "LINE認証エラー: #{e.message}"
    redirect_to root_path, alert: "LINE認証に失敗しました"
  end
end
