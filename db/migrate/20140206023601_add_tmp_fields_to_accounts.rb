class AddTmpFieldsToAccounts < ActiveRecord::Migration
  def change

    add_column :accounts, :tmp_1, :string
    add_column :accounts, :tmp_2, :string

    

  end
end
