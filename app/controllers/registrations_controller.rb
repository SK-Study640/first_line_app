class RegistrationsController < ApplicationController
  # before_action :user_params

  def new
    # 新規登録画面表示
    @user = User.new(name: params[:name], line_user_id: params[:line_user_id], provider: params[:provider], tmp_profile_file_path: params[:tmp_profile_file_path])
  end

  def confirm
    # 入力内容確認画面表示
    @user = User.new(name: params[:name], line_user_id: params[:line_user_id], provider: params[:provider], tmp_profile_file_path: params[:tmp_profile_file_path])
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def complete
    # 登録完了画面表示
  end

  private
  def user_params
    params.require(:user).permit(:name, :line_user_id, :provider, :tmp_profile_file_path)
  end
end
