class CreateImageCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :image_characters do |t|
      t.references :image
      t.references :character

      t.timestamps
    end
    add_index :image_characters, :image
    add_index :image_characters, :character
    add_index :image_characters, [:image, :character], unique: true
  end
end
