class UsersController < ApplicationController
  before_action :find_user, only: %i[show upload destroy]

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

=begin
  def upload
    if params[:user].present? && params[:user][:avatar].present?
      @user.avatar.attach(params[:user][:avatar])
      # user.update(avatar: params[:user][:avatar])
      redirect_to user, notice: 'Avatar uploaded successfully.'
    else
      redirect_to user, notice: 'Avatar uploaded unsuccessfully.'
    end
  end
=end

  def upload
    user = User.find(params[:id])
    if params[:user].present? && params[:user][:avatar].present?

      user.avatar.attach(params[:user][:avatar])

      redirect_to user, notice: 'Avatar uploaded successfully!'
    else
      redirect_to user, alert: 'No file selected for upload!'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
