class CreateMovimentations < ActiveRecord::Migration
  def change
    create_table :movimentations do |t|
      t.references :account
      t.string :operation
      t.decimal :quantity, precision: 8, scale: 2
      t.integer :account_destiny_id, :integer, nil: true
      t.timestamps
    end
  end
end
