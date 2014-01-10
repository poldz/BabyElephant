class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :account_name
      t.string :account_type
      t.string :account_number
      t.string :city_or_town
      t.string :province_or_state
      t.string :account_servant_name
      t.string :secritary_name
      t.string :checking_account_rename
      t.string :other_account_name

      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
