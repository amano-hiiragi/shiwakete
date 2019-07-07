class CreateUserTags < ActiveRecord::Migration[5.1]
  def change
    create_table :user_tags do |t|
      t.string :title_of_work
      t.string :character_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
