class PostsController < ApplicationController
  
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to post_path(@post)
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.content = params[:content]
    @post.save
    if @post.save
      redirect_to(post_path(@post), success: '更新しました。')
    else
      render :edit
      flash.now['danger'] = '編集に失敗しました'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_back fallback_location: root_path, danger: '投稿を削除しました'
  end
end