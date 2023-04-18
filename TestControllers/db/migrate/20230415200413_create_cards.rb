class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.belongs_to :folder
      t.string :word
      t.string :translation

      t.timestamps
    end
  end
end
