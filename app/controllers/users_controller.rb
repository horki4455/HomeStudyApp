class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to(root_path, success: '登録に成功しました')
      else
        flash.now[:danger] = '登録に失敗しました。'
        render :new
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :last_name, :first_name)
    end
  end
