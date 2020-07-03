class Admin::CommentsController < Admin::BaseController

  def index
    @comments = Comment.all.includes(:board).order(created_at: :desc)
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to admin_board_path(@comment.board), success:'作成成功'
    else
      redirect_to admin_board_path(@comment.board), danger: '作成失敗'
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end