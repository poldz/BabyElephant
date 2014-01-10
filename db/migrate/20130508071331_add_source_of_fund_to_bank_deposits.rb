class AddSourceOfFundToBankDeposits < ActiveRecord::Migration
  def change
    add_column :bank_deposits, :source_of_fund, :string
  end
end
