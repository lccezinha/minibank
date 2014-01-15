class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :number
      t.decimal :total, precision: 8, scale: 2, default: 100
      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
