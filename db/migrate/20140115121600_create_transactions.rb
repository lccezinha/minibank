class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :account
      t.string :operation
      t.decimal :value, precision: 8, scale: 2
      t.timestamps
    end
  end
end
