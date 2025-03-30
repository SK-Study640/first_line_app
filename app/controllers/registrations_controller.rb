class RegistrationsController < ApplicationController
  before_action :check_login_user, except: :complete

  def new
    # 新規登録画面表示
    @user = User.new(name: params[:name], line_user_id: params[:line_user_id], provider: params[:provider], tmp_profile_file_path: params[:tmp_profile_file_path])
  end

  def confirm
    # 入力内容確認画面表示
    p "params[:line_user_id] is #{params[:line_user_id]}"
    @user = User.new(name: params[:name], line_user_id: params[:line_user_id], provider: params[:provider], tmp_profile_file_path: params[:tmp_profile_file_path])
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def create
    # 登録処理
    user = User.new(name: params[:name], line_user_id: params[:line_user_id], provider: params[:provider], tmp_profile_file_path: params[:tmp_profile_file_path])
    p "params[:line_user_id] is #{params[:line_user_id]}"
    user.birthday = Date.new(Integer(params[:year]), Integer(params[:month]), Integer(params[:day]))
    begin
      if user.save
        sign_in(user)
        redirect_to complete_registrations_path(user_id: user.id),  notice: "Success to register"
      else
        redirect_to confirm_registrations_path, notice: "Failed to register"
      end
    rescue => e
      Rails.logger.error("Error saving user: #{e.message}")
      redirect_to confirm_registrations_path, notice: "Failed to register"
    end
  end

  def complete
    # 登録完了画面表示
    @user_id = current_user.id
  end

  private
  # 登録済みユーザーの場合はマイページに遷移する
  def check_login_user
    if User.exists?(line_user_id: params[:line_user_id])
      @user = User.find_by(line_user_id: params[:line_user_id])
      sign_in(@user)
      redirect_to users_path(@user)
    end
  end
end
