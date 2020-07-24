class TasksController < ApplicationController

before_action :set_task, only: %i[edit update destroy]

  def index
    @tasks = current_user.tasks.includes(:user).order(created_at: :desc)
  end

  def show
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      flash[:success] = 'タスクが投稿されました'
      redirect_to tasks_path
    else
      flash[:danger] = 'タスクが投稿されません'
      render :new
    end
  end

  def edit;end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが編集されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクが編集されませんでした'
      render :new
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'タスクが削除されました'
    redirect_to tasks_path
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
