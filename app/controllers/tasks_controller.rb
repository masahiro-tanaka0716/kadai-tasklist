class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end
  
  def show
  end
  
  def new
    if logged_in?
      @task = current_user.tasks.build  # form_with 用
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスクを登録できませんでした。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = 'タスクを変更しました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクを更新できませんでした。'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'タスクを削除しました。'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:status, :content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
