class LineAuthController < ApplicationController
  # LINE認証関連コントローラ
  def callback
    auth = request.env("omniauth.auth")

    # LINEユーザーIDをもとに既存ユーザー検索 or 新規作成
    user = User.find_or_initialize_by(line_user_id: auth["uid"])
    user.name = auth["info"]["name"]
    user.save!

    # ユーザーをログイン状態にする
    session[:user_id] = user.id
    redirect_to root_path, notice: "LINEでログインしました！"
  rescue StandardError => e
    Rails.logger.error "LINE認証エラー: #{e.message}"
    redirect_to root_path, alert: "LINE認証に失敗しました。"
  end

  # 認証失敗時の処理
  def failure
    redirect_to root_path, alert: "LINE認証がキャンセルされました。"
  end
end
