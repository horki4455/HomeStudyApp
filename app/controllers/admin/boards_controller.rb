class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[update destroy edit]
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show; end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save!
      redirect_to(admin_boards_path, success: '掲示板を作成しました。')
    else
      flash.now[:danger] = '掲示板の作成に失敗しました。'
      render :new
    end
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to(admin_boards_path(@board), success: '掲示板を更新しました。')
    else
      flash.now[:danger] = '掲示板の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @board.destroy!
    redirect_to(admin_boards_path, success: '掲示板を消去しました。')
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :image)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end