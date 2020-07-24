class Admin::MemosController < Admin::BaseController
  def index
    @q = current_user.memos.ransack(params[:q])
    @memos = @q.result(distinct: true).includes(:student).order(created_at: :desc)
  end

  def show
    @memo = Memo.find(params[:id])
  end

  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      redirect_to admin_student_path(@memo.student), success:'作成成功'
    else
      redirect_to admin_student_path(@memo.student), danger: '作成失敗'
    end
  end

  def edit
    @memo = current_user.memos.find(params[:id])
  end

  def update
    @memo = current_user.memos.find(params[:id])
    if @memo.update(memo_update_params)
      redirect_to(edit_admin_memo_path(@memo), success: '掲示板を更新しました。')
    else
      flash.now[:danger] = '掲示板の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to(admin_student_memos_path(@memo), danger:  '投稿を削除しました')
  end

  def memo_params
    params.require(:memo).permit(:body).merge(student_id: params[:student_id])
  end

  def memo_update_params
    params.require(:memo).permit(:body)
  end
end
