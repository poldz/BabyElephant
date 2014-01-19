class AddNoteDepositsAndWithdrawals < ActiveRecord::Migration
  def change
    add_column :bank_deposits, :note, :string
    add_column :bank_withdrawals, :note, :string
  end
end
