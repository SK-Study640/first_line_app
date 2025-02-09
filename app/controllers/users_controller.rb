class UsersController < ApplicationController
  before_action :set_user

  # Userビューのルーティング。
  # UserのStatus応じたビューにリダイレクトする
  def route
    case @user.status
    when "unset"
      redirect_to unset_users_path
    when "pending"
      redirect_to pending_users_path
    when "incoming"
      redirect_to incoming_users_path
    when "registered"
      redirect_to registered_users_path
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

  private
  def set_user
    @user = current_user
  end
end
