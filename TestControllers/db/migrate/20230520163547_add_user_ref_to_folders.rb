class AddUserRefToFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :user, null: true, foreign_key: true
  end
end
