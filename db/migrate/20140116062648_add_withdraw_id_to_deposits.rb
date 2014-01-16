class AddWithdrawIdToDeposits < ActiveRecord::Migration
  def change
    add_column :bank_deposits, :bank_withdrawal_id, :integer
  end
end
