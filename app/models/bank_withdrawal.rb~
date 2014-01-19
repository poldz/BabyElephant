class BankWithdrawal < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period

  has_many :expenses
  has_many :remittances


  attr_accessible :amount, :bank_account, :created_by_id, :date, :note

  before_validation :set_account_and_user

  validates :amount, :presence => true, :numericality => {:greater_than => 0.00}
  validates :bank_account, :presence => true

  def display_name
    "[#{date}] #{bank_account} (#{amount})"
  end



  protected
  
  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end

end
