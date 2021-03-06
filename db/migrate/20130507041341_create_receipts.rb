class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.references :user
      t.references :account
      t.references :accounting_period
      t.integer :created_by_id
      t.date :date
      t.decimal :worldwide_work, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.decimal :kingdom_hall_construction_worldwide, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.decimal :local_congregation_expenses, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.string :other_1
      t.decimal :other_1_amount, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.string :other_1_for
      t.string :other_2
      t.decimal :other_2_amount, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      t.string :other_2_for
      t.decimal :total, :precision => 12, :scale => 2, :default => 0.00, :default => 0.00
      
      t.string :account_servant_name
      t.string :verified_by

      t.timestamps
    end
    add_index :receipts, :user_id
    add_index :receipts, :account_id
    add_index :receipts, :accounting_period_id
    add_index :receipts, :created_by_id
    add_index :receipts, :date
  end
end
