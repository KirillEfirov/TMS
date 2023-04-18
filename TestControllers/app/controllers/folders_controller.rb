class FoldersController < ApplicationController
  def index
    @folders = Folder.includes(:cards).all
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      redirect_to folders_path
    else
      render :index
    end
  end

  def update
    @folder = Folder.find(params[:id])

    if @folder.update(folder_params)
      redirect_to folders_path
    else
      render :index
    end
  end

  def destroy
    @folder = Folder.find(params[:id])

    if @folder.destroy
      redirect_to folders_path
    else
      render :index
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
