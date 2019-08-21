class AddAlertColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :alert_date, :date, null: true, default: :null
  end
end
