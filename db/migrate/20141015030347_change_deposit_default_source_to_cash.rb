class ChangeDepositDefaultSourceToCash < ActiveRecord::Migration
  def up
    change_column :bank_deposits, :source_of_fund, :string, :default => 'Cash on Hand'
  end

  def down
    change_column :bank_deposits, :source_of_fund, :string, :default => nil
  end
end