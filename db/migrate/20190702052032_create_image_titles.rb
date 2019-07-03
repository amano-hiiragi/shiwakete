class CreateImageTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :image_titles do |t|
      t.references :image
      t.references :title

      t.timestamps
    end
    add_index :image_titles, [:image_id, :title_id], unique: true
  end
end
