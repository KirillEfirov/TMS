class FoldersController < ApplicationController
  def index
    @folders = Folder.includes(:cards).all
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def create
    @folder = Folder.new(folder_params)

    @folder.save

    redirect_to folders_path
  end

  def update
    @folder = Folder.find(params[:id])

    @folder.update(folder_params)

    redirect_to folders_path
  end

  def destroy
    @folder = Folder.find(params[:id])

    @folder.destroy

    redirect_to folders_path
  end

  def learn
    @cards = WordlistCreator.call
  end

  private

  def folder_params
    params.require(:folder).permit(:name)
  end
end
