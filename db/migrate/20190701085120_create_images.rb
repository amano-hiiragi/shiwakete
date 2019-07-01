class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url

      t.timestamps
    end
    add_index :images, :url, unique: true
  end
end
