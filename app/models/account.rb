class Account < ActiveRecord::Base
  belongs_to :user
  has_many :accounting_periods

  # Note: tmp_1 and tmp_2 are just temporary value holder while recurring_remittances and expences and other bank_account_notes are not yet in place

  validates :account_name, :account_type, :account_number, :account_servant_name, :city_or_town, :province_or_state, :presence => true
end
