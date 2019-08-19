class CreatePostProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :post_projects do |t|
      t.integer :post_id
      t.string :project_id
      t.string :integer

      t.timestamps
    end
  end
end
