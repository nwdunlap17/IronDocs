class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :title
      t.integer :user_id
      t.integer :urgency_level

      t.timestamps
    end
  end
end
