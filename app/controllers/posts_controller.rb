class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
    @user = current_user
  end

  def show
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:success] = "投稿を作成しました"
      redirect_to post_path(@post)
    else
      flash[:danger] = "投稿を作成できませんでした"
      render :new
    end
  end

  def edit;end

  def update
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to(post_path(@post), success: '更新しました。')
    else
      render :edit
      flash.now['danger'] = '編集に失敗しました'
    end
  end

  def destroy
    @post.destroy
    redirect_back_or_to(posts_path, danger:  '投稿を削除しました')
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end