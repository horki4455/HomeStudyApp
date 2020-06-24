class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :require_login

  def log_in(user)
    session[:user_id] = user.id #ゲストログイン機能実装に使用します
  end

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to login_path
  end
end
