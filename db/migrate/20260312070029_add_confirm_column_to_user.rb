class AddConfirmColumnToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :confirmed, :boolean, default: false, null: false
  end
end
