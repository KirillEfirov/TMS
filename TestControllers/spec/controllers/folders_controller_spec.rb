require 'rails_helper'

RSpec.describe FoldersController, type: :request do
  describe 'GET folders_controller#index' do
    it 'renders the index template' do
      get folders_path

      expect(response).to render_template(:index)
    end

    it 'returns status 200' do
      get folders_path

      expect(response).to have_http_status(:ok)
    end

    it 'eager loads cards for each folder' do
      folder = create(:folder) do |f|
        2.times { create(:card, folder: f) }
      end

      get folders_path

      expect(assigns(:folders)).to match_array([folder])
      expect(assigns(:folders).first.cards.loaded?).to be true
    end

    it 'checks if @folders in my controller match all the created folders' do
      folders = create_list(:folder, 3)

      get folders_path

      expect(assigns(:folders)).to match_array(folders)
    end
  end

  describe 'GET folders_controller#show' do
    it 'renders the show page' do
      folder = create(:folder)

      get folder_path(folder)

      expect(response).to render_template(:show)
    end

    it 'assigns @folder to correct folder' do
      folder = create(:folder)

      get folder_path(folder)

      expect(assigns(:folder)).to eq(folder)
    end
  end

  describe 'POST folders_controller#create' do
    context 'with valid params' do
      let(:valid_params) { { name: 'New folder' } }

      it 'redirects to all the available folders' do
        post folders_path, params: { folder: valid_params }

        expect(response).to redirect_to(folders_path)
      end

      it 'counts folders in the right way' do
        2.times { create(:folder) }

        post folders_path, params: { folder: valid_params }

        expect(Folder.all.count).to be == 3
      end

      it 'adds +1 folder' do
        2.times { create(:folder) }

        expect { post folders_path, params: { folder: valid_params } }.to change { Folder.all.count }.from(2).to(3)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { name: 'New folder', folder_id: 'lalaland' } }

      it 'renders the same page' do
        post folders_path, params: { folder: invalid_params }

        expect(response).to redirect_to(folders_path)
      end

      it 'doesn\'t add +1 folder' do
        # expect { post folders_path, params: { folder: invalid_params } }.to change { Folder.all.count }.from(0).to(0)
        # or
        expect { post folders_path, params: { folder: invalid_params } }.to_not change(Folder, :count)
      end
    end
  end

  describe 'PATCH folders_controller#update' do
    let(:folder) { create(:folder) }

    context 'with valid parameters' do
      let(:updated_folder_params) { { name: 'Updated Folder' } }

      it 'updates the folder' do
        patch folder_path(folder), params: { folder: updated_folder_params }
        folder.reload
        expect(folder.name).to eq('Updated Folder')
      end

      it 'redirects to the index page' do
        patch folder_path(folder), params: { folder: updated_folder_params }
        expect(response).to redirect_to(folders_path)
      end
    end

=begin
    context 'with invalid parameters' do
      let(:invalid_folder_params) { { name: '', folder_id: 'lalaland' } }

      it 'does not update the folder' do
        patch folder_path(folder), params: { folder: invalid_folder_params }
        folder.reload
        expect(folder.name).to_not eq('')
      end

      it 'renders the index template' do
        patch folder_path(folder), params: { folder: invalid_folder_params }
        expect(response).to render_template(:index)
      end
    end
=end
  end

  describe 'DELETE folders_controller#destroy' do
    let!(:folder) { create(:folder) }

    it 'deletes the folder' do
      expect { delete folder_path(folder) }.to change(Folder, :count).by(-1)
    end

    it 'redirects to the index page' do
      delete folder_path(folder)
      expect(response).to redirect_to(folders_path)
    end

=begin
    context 'when folder deletion fails' do
      before do
        allow_any_instance_of(Folder).to receive(:destroy).and_return(false)
      end

      it 'does not delete the folder' do
        expect { delete folder_path(folder) }.to_not change(Folder, :count)
      end

      it 'renders the index template' do
        delete folder_path(folder)
        expect(response).to render_template(:index)
      end
    end
=end
  end
end
