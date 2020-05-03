class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/admin'

  private

  def not_authenticated
    flash[:warning] = '権限が与えられていません'
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, warning: 'ログインしてください' unless current_user.admin?
  end
end
