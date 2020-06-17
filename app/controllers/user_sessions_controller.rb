class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest]
  layout 'admin/layouts/admin_login'
    def new;end
  
    def create
      @user = login(params[:email], params[:password])
  
      if @user
        redirect_back_or_to(root_path, success: 'ログインしました')
      else
        flash.now[:danger] = '登録に失敗しました。'
        render :new
      end
    end
  
    def destroy
      logout
      redirect_back_or_to(root_path, success: 'ログアウトしました')
    end

    def guest
      user = User.find_by(email: 'test@example.com')
      log_in(user)
      flash[:success] = 'ゲストユーザーでログインしました'
      flash[:warning] = 'よろしくお願いします！'
      redirect_to root_path
    end
  end