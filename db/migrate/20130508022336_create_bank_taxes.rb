class CreateBankTaxes < ActiveRecord::Migration
  def change
    create_table :bank_taxes do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.integer :created_by_id
      t.date :date
      t.string :bank_account
      t.decimal :amount, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00

      t.timestamps
    end
    add_index :bank_taxes, :user_id
    add_index :bank_taxes, :account_id
    add_index :bank_taxes, :accounting_period_id
    add_index :bank_taxes, :created_by_id
    add_index :bank_taxes, :date
  end
end
