class CreateInviteIds < ActiveRecord::Migration[8.1]
  def change
    create_table :invite_ids do |t|
      t.string :invite_id, null: false
      t.boolean :used, default: false, null: false
      t.references :user, null: true, foreign_key: true
      t.timestamps
    end

    add_index :invite_ids, :invite_id, unique: true
  end
end
