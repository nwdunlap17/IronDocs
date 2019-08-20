class AddViewsColumnToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :views, :integer, :default => 0
  end
end
