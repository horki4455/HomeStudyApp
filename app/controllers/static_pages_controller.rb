class StaticPagesController < ApplicationController
  skip_before_action :require_login

    def top
      @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
      @user = current_user
    end
  end
