class Account < ActiveRecord::Base
  belongs_to :user
  has_many :accounting_periods

  #has_many :receipts
  #has_many :bank_deposits
  #has_many :bank_withdrawals
  #has_many :bank_interests
  #has_many :bank_taxes
  #has_many :bank_penalties
  #has_many :bank_fees
  #has_many :bank_other_transactions

  #has_many :expenses
  #has_many :remittances


  attr_accessible :account_name, :account_number, :account_servant_name, :account_type, :checking_account_rename, :city_or_town, :other_account_name, 
                  :province_or_state, :secritary_name, :society_bank_account_name, :society_bank_account_number

  validates :account_name, :account_type, :account_number, :account_servant_name, :city_or_town, :province_or_state, :presence => true
end
