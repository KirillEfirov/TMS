class UsersController < ApplicationController
  before_action :find_user, only: %i[show upload]

  def index
    @users = User.all
  end

  def show
    @current_user = current_user
    @folders = Folder.includes(:cards).where(user: @user)
  end

  def upload
    if params[:user].present? && params[:user][:avatar].present?
      @user.avatar.attach(params[:user][:avatar])

      redirect_to @user, notice: 'Avatar uploaded successfully!'
    else
      redirect_to @user, alert: 'No file selected for upload!'
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
