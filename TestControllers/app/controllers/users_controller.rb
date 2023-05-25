class UsersController < ApplicationController
  before_action :find_user, only: %i[show update destroy]

  def index
    @users = User.all
  end

  def show
    @current_user = current_user
    @folders = Folder.includes(:cards).where(user: @user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: 503
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
