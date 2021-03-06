class LikesController < ApplicationController

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    if @like.save
      redirect_back fallback_location: root_path, success: 'いいねしました'
    else
      render :edit
      flash.now['danger'] = 'いいねに失敗しました'
    end
  end

  def destroy
    @like = Like.find(params[:post_id])
    @like.destroy
    redirect_back fallback_location: root_path, danger: 'いいねを削除しました'
  end
end
