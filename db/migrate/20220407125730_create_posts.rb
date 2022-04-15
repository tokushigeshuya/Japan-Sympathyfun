class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :area_id
      t.integer :user_id
      t.string :title
      t.text :body
      t.text :address
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
