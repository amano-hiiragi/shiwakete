class CreateTitles < ActiveRecord::Migration[5.1]
  def change
    create_table :titles do |t|
      t.string :title_of_work

      t.timestamps
    end
    add_index :titles, :title_of_work, unique: true
  end
end
