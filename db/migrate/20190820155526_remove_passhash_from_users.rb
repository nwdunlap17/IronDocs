class RemovePasshashFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :passhash, :string
  end
end
