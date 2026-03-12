class AddUrlToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :url, :string, default: "", null: false
    add_index :users, :url
  end
end
