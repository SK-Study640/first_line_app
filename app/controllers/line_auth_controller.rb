class LineAuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :callback ]

  def callback
    auth = request.env["omniauth.auth"]  # LINEからの認証情報を取得
    @user = User.find_or_initialize_by(uid: auth["uid"], provider: auth["provider"])
    @user.name = auth["info"]["name"]
    @user.line_user_id = auth["uid"]
    @user.provider = auth["provider"]
    image_file_path = image(auth, @user.id)
    # ユーザーをログイン状態にする
    session[:@user_id] = @user.id
    redirect_to new_registrations_path(user_id: @user.id, user_name: @user.name, user_uid: @user.line_user_id, user_provider: @user.provider, image_file_path: image_file_path)
  end

  def failure
    Rails.logger.error "LINE認証エラー: #{e.message}"
    redirect_to root_path, alert: "LINE認証に失敗しました"
  end

  def image(auth, user_id)
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
    file_path = Rails.root.join("tmp", user_id.to_s)
    File.open(file_path, "wb") { |f| f.write(image_file) }
    file_path
  end

  # def process
  #   temp_image_path = params[:temp_image_path]
  #   if temp_image_path && File.exist?(temp_image_path)
  #     # 画像を処理
  #     File.delete(temp_image_path) # 処理後に一時ファイルを削除
  #   else
  #     flash[:alert] = "画像ファイルが見つかりません。"
  #     redirect_to new_upload_path
  #   end
  # end
end
