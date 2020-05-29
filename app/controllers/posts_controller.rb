class PostsController < ApplicationController
  
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page]).per(3)
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
      redirect_to(posts_path, success: '作成に成功しました')
    else
      render :new
      flash.now['danger'] = '作成に失敗しました'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    @post.save
    if @post.save
      redirect_to(post_path(@post), success: '更新しました。')
    else
      render("posts/edit")
    end
  end

end