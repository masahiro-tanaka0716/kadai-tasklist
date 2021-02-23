class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:id]).per(10)
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザー登録する'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー登録失敗しました。'
      render :new
    end
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
