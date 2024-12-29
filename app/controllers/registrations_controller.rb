class RegistrationsController < ApplicationController
  def new
    # 新規登録画面表示
    @user = User.find(session[:user_id])
  end

  def confirm
    # 入力内容確認画面表示
    @user = User.find(session[:user_id])
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def complete
    # 登録完了画面表示
  end
end
