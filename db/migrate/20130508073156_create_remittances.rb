class CreateRemittances < ActiveRecord::Migration
  def change
    create_table :remittances do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.references :bank_withdrawal
      t.integer :created_by_id
      t.date :date
      t.string :source_of_fund
      t.string :remittance_type
      t.string :description
      t.decimal :amount, :precision => 12, :scale => 2, :default => 0.00
      t.string :notes

      t.timestamps
    end
    add_index :remittances, :user_id
    add_index :remittances, :account_id
    add_index :remittances, :accounting_period_id
    add_index :remittances, :bank_withdrawal_id
    add_index :remittances, :created_by_id
    add_index :remittances, :date
  end
end
