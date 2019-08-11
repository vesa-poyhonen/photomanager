class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :title
      t.string :filename

      t.timestamps
    end

    add_foreign_key :pictures, :users
  end
end
