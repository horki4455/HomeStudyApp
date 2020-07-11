class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :check_guest, only: %i[edit update]
  
  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: 'ユーザー情報を更新しました'
    else
      render :edit
      flash.now['danger'] = '編集に失敗しました'
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :image)
  end

  def check_guest
    if 'test@example.com' == current_user.email
      redirect_to profile_path, danger: 'ゲストユーザーの変更・削除はできません'
    end
  end
end
