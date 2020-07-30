class Admin::BlogsController < Admin::BaseController
  before_action :set_blog, only: %i[show edit update destroy]

  def index
    @blogs = current_user.blogs.includes(:user).order(created_at: :desc)
  end

  def new
    @blog = Blog.new
  end

  def show;end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to(admin_blogs_path, success: '予定を作成しました。')
    else
      flash.now[:danger] = '予定の作成に失敗しました。'
      render :new
    end
  end

  def destroy
    @blog.destroy
    redirect_to admin_blogs_path, danger:"削除しました"
  end

  def edit;end

  def update
    if @blog.update(blog_params)
      redirect_to admin_blogs_path, success: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :start_time)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
