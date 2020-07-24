class CommentsController < ApplicationController

  def index
    @q = current_user.comments.ransack(params[:q])
    @comments = @q.result(distinct: true).includes(:board).order(created_at: :desc)
  end
  

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to board_path(@comment.board), success:'作成成功'
    else
      redirect_to board_path(@comment.board), danger: '作成失敗'
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      redirect_to(comments_path, success: '掲示板を更新しました。')
    else
      flash.now[:danger] = '掲示板の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to(comments_path, danger:  '投稿を削除しました')
  end
  
  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end

  def comment_update_params
    params.require(:comment).permit(:body)
  end
end