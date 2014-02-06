class Account < ActiveRecord::Base
  belongs_to :user
  has_many :accounting_periods

  attr_accessible :account_name, :account_number, :account_servant_name, :account_type, :checking_account_rename, :city_or_town, :other_account_name, 
                  :province_or_state, :secritary_name, :society_bank_account_name, :society_bank_account_number,
                  :checking_account_name_on_bank_account, :checking_account_bank_account_number, :other_account_name_on_bank_account, :other_account_bank_account_number,
                  :tmp_1, :tmp_2
  # Note: tmp_1 and tmp_2 are just temporary value holder while recurring_remittances and expences and other bank_account_notes are not yet in place

  validates :account_name, :account_type, :account_number, :account_servant_name, :city_or_town, :province_or_state, :presence => true
end
