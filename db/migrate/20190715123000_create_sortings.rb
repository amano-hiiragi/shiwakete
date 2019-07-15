class CreateSortings < ActiveRecord::Migration[5.1]
  def change
    create_table :sortings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :image, foreign_key: true, null: false
      t.references :title, foreign_key: true
      t.references :character, foreign_key: true

      t.timestamps
    end
  end
end
