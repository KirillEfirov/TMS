class FoldersController < ApplicationController
  before_action :find_current_user, only: %i[create update destroy]

  def index
    @folders = Folder.includes(:cards).all
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def create
    @folder = Folder.new(folder_params.merge(user: @current_user))
    @folder.save

    redirect_to user_path(@current_user)
  end

  def update
    @folder = Folder.find(params[:id])

    if @folder.user.id == @current_user.id
      @folder.update(folder_params.merge(user: @current_user))
    else
      flash[:error] = "You can't change this folder"
    end

    redirect_to user_path(@current_user)
  end

  def destroy
    @folder = Folder.find(params[:id])

    if @folder.user.id == @current_user.id
      @folder.destroy
    else
      flash[:error] = "You can't delete this folder"
    end

    redirect_to user_path(@current_user)
  end

  def learn
    @cards = WordlistCreator.call
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end

  def find_current_user
    @current_user = current_user
  end
end
