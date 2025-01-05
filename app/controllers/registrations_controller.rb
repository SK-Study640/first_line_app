class RegistrationsController < ApplicationController
  before_action :set_user

  def new(user)
    # 新規登録画面表示
    @user = User.find(session[:user_id])
  end

  def confirm(user)
    # 入力内容確認画面表示
    @user = User.find(session[:user_id])
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def complete
    # 登録完了画面表示
    #
    # Active record登録用コード備忘
    # @user.profile_image.attach(io: image_file, filename: "profile_#{@user.id}.jpg", content_type: "image/jpeg")
    #
  end

  private
  def set_user
    @user = User.new(
      params[:user_id],
      params[:user_name],
      params[:user_uid],
      params[:user_provider]
    )
  end
end
