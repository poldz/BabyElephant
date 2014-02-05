class AddBankAccountDetails < ActiveRecord::Migration
  def change

    add_column :accounts, :checking_account_name_on_bank_account, :string
    add_column :accounts, :checking_account_bank_account_number, :string

    add_column :accounts, :other_account_name_on_bank_account, :string
    add_column :accounts, :other_account_bank_account_number, :string

  end
end
