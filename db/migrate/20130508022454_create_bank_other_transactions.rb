class CreateBankOtherTransactions < ActiveRecord::Migration
  def change
    create_table :bank_other_transactions do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.integer :created_by_id
      t.date :date
      t.string :bank_account
      t.string :description
      t.string :notes
      t.decimal :amount, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.string :transaction_type

      t.timestamps
    end
    add_index :bank_other_transactions, :user_id
    add_index :bank_other_transactions, :account_id
    add_index :bank_other_transactions, :accounting_period_id
    add_index :bank_other_transactions, :created_by_id
    add_index :bank_other_transactions, :date
  end
end
