class CreateAccountingPeriods < ActiveRecord::Migration
  def change
    create_table :accounting_periods do |t|
      t.references :user
      t.references :account
      t.integer :created_by_id
      t.date :date
      t.string :checking_account_rename
      t.string :other_account_name
      t.decimal :receipts_balance_forward, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.decimal :checking_balance_forward, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :other_account_balance_forward, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_funds_at_bom, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_funds_at_eom, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_funds_rfsp, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_funds_atcce, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :surplus_deficit, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_receipts, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :total_expenditures, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :for_worldwide_work, :precision => 12, :scale => 2, :default => 0.00
      t.decimal :for_kingdom_hall_construction_worldwide, :precision => 12, :scale => 2, :default => 0.00

      t.timestamps
    end
    add_index :accounting_periods, :user_id
    add_index :accounting_periods, :account_id
    add_index :accounting_periods, :created_by_id
    add_index :accounting_periods, :date
  end
end
