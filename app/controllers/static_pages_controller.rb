class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]

    def top
      @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
      @user = current_user
    end

    def create
      @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
      if @like.save
        redirect_back fallback_location: root_path, success: 'いいねしました'
      else
        render :edit
        flash.now['danger'] = '編集に失敗しました'
      end
    end
  
    def destroy
      @like = Like.find(params[:post_id])
      @like.destroy
      redirect_back fallback_location: root_path, danger: 'いいねを削除しました'
    end
  end
