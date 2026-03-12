class AddEncryptedPasswordToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :encrypted_password, :string, null: false, default: ""

    add_index :users,
              %i[provider uid],
              unique: true,
              where: "provider != '' AND uid != ''"
  end
end

