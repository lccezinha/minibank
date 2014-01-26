class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :number
      t.decimal :total, default: 100.00, precision: 8, scale: 2, nil: false
      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
