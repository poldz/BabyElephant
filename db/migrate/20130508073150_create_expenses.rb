class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.references :bank_withdrawal
      t.integer :created_by_id
      t.date :date
      t.string :source_of_fund
      t.string :description
      t.decimal :amount, :precision => 12, :scale => 2, :default => 0.00
      t.string :notes

      t.timestamps
    end
    add_index :expenses, :user_id
    add_index :expenses, :account_id
    add_index :expenses, :accounting_period_id
    add_index :expenses, :bank_withdrawal_id
    add_index :expenses, :created_by_id
    add_index :expenses, :date
  end
end
