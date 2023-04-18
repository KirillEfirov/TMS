class CardsController < ApplicationController
  def create
    @folder = Folder.find(params[:folder_id])
    @card = Card.new(word: params[:card][:word], translation: params[:card][:translation], folder: @folder)

    @card.save ? flash[:success] = 'Card created successfully' : flash[:error] = 'Card creation failed'

    redirect_to folder_path(@folder)
  end

  def update
    @folder = Folder.find(params[:folder_id])
    @card = @folder.cards.find(params[:id])

    redirect_to folder_path(@folder) if @card.update(card_params)
  end

  def destroy
    @folder = Folder.find(params[:folder_id])
    @card = Card.find(params[:id])

    redirect_to folder_path(@folder) if @card.destroy
  end

  private

  def card_params
    params.require(:card).permit(:word, :translation)
  end
end
