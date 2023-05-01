require 'rails_helper'

RSpec.describe CardsController, type: :request do
  describe 'POST cards_controller#create' do
    let(:folder) { create(:folder) }
    let(:valid_attributes) { attributes_for(:card) }

    it 'finds the appropriate folder' do
      post folder_cards_path(folder), params: { folder_id: folder.id, card: valid_attributes }

      expect(assigns(:folder)).to eq(folder)
    end

    it 'creates a new card' do
      expect {
        post folder_cards_path(folder), params: { folder_id: folder.id, card: valid_attributes }
      }.to change(Card, :count).by(1)
    end

    context 'when creating card succsessfully' do
      it 'outputs succsessfull flash message' do
        post folder_cards_path(folder), params: { folder_id: folder.id, card: valid_attributes }

        expect(flash[:success]).to eql('Card was created successfully')
      end
    end

    context 'when creation fails' do
      it 'outputs not successful message' do
        allow_any_instance_of(Card).to receive(:save).and_return(false)

        post folder_cards_path(folder), params: { folder_id: folder.id, card: valid_attributes }

        expect(flash[:error]).to eql('Card creation failed')
      end
    end

    it 'redirects to folder in which the card was created' do
      post folder_cards_path(folder), params: { folder_id: folder.id, card: valid_attributes }

      expect(response).to redirect_to(folder_cards_path(folder))
    end
  end

  describe 'PUT cards_controller#update' do
    let(:folder) { create(:folder) }
    let(:card) { create(:card, folder: folder) }

    it 'finds an appropriate card' do
      card_to_update = create(:card, word: 'Word to find', folder: folder)

      put folder_card_path(folder, card_to_update), params: { folder_id: folder.id, card: card_to_update.attributes }

      expect(assigns(:card).word).to eq('Word to find')
    end

    it 'updates an existing card' do
      card_to_update = create(:card, word: 'Word to update', translation: 'Translation to update', folder: folder)
      new_attributes = { word: 'New word', translation: 'New translation' }

      put folder_card_path(folder, card_to_update), params: { folder_id: folder.id, card: new_attributes }

      card_to_update.reload

      expect(card_to_update.word).to eq('New word')
      expect(card_to_update.translation).to eq('New translation')
    end

    it 'redirects to the same page' do
      put folder_card_path(folder, card), params: { folder_id: folder.id, card: attributes_for(:card) }

      expect(response).to redirect_to(folder_cards_path(folder))
    end
  end

  describe 'DELETE cards_controller#destroy' do
    let!(:folder) { create(:folder) }
    let!(:card) { create(:card, folder: folder) }

    it 'finds an appropriate card' do
      card_to_delete = create(:card, word: 'Word to find', folder: folder)

      delete folder_card_path(folder, card_to_delete), params: { folder_id: folder.id, card: card_to_delete.attributes }

      expect(assigns(:card).word).to eq('Word to find')
    end

    it 'deletes the card' do
      expect { delete folder_card_path(folder, card) }.to change(folder.cards, :count).by(-1)
    end

    it 'redirects to the folder where card was removed' do
      delete folder_card_path(folder, card), params: { folder_id: folder.id, card: attributes_for(:card) }

      expect(response).to redirect_to(folder_cards_path(folder))
    end
  end
end
