class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :character_name

      t.timestamps
    end
    add_index :characters, :character_name, unique: true
  end
end
