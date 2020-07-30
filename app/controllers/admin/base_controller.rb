class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :check_admin
  layout 'admin/layouts/admin'

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to login_path
  end

  def check_admin
    redirect_to login_path, warning: '先生権限がありません' unless current_user.admin?
  end
end
