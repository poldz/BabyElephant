class CreateBankFees < ActiveRecord::Migration
  def change
    create_table :bank_fees do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.integer :created_by_id
      t.date :date
      t.string :bank_account
      t.string :description
      t.string :notes
      t.decimal :amount, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00

      t.timestamps
    end
    add_index :bank_fees, :user_id
    add_index :bank_fees, :account_id
    add_index :bank_fees, :accounting_period_id
    add_index :bank_fees, :created_by_id
    add_index :bank_fees, :date
  end
end
