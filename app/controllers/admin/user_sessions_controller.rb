class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'admin/layouts/admin_login'
  def new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_to(admin_root_path, success: '管理者としてログインしました')
    else
      flash.now[:danger] = '管理者ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to(admin_login_path, success: 'ログアウトしました')
  end
end