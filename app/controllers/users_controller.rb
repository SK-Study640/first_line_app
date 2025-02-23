class UsersController < ApplicationController
  before_action :set_user

  # Userビューのルーティング。
  # UserのStatus応じたビューにリダイレクトする
  def route
    case @user.status
    when "unset"
      redirect_to users_unset_path
    when "pending"
      redirect_to users_pending_path
    when "incoming"
      redirect_to users_incoming_path
    when "registered"
      redirect_to users_registered_path
    end
  end

  def unset
    # マイページ（未登録）表示
  end

  def pending
    # マイページ（未登録）表示
  end

  def incoming
    # マイページ（申請が来ている）表示
  end

  def registered
    # マイページ（登録済み）表示
  end

  # 開発用機能
  def index
    @users = User.all
    # 恋人申請中の場合は申請相手を取得する
    @users.each do |user|
      if user.status === pending
        # 恋人申請中の場合
        user.application_for = "pending:#{user.partner}"
      end
      if user.status === incoming
        # 恋人申請中の場合
        user.application_for = "pending:#{user.partner}"
      end
    end
  end

  def switch_user
    sign_in(User.find(params[:id]))
    redirect_to users_path
  end

  private
  def set_user
    @user = current_user
  end
end
