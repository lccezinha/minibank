class AddTransfersFieldsToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :account_destiny_id, :integer, nil: true
  end
end
