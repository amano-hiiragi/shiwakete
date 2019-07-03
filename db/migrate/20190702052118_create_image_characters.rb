class CreateImageCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :image_characters do |t|
      t.references :image
      t.references :character

      t.timestamps
    end
    add_index :image_characters, [:image_id, :character_id], unique: true
  end
end
