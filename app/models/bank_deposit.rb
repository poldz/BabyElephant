class BankDeposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period
  attr_accessible :source_of_fund, :amount, :bank_account, :created_by_id, :date


  before_validation :set_account_and_user

  validates :amount, :presence => true, :numericality => {:greater_than => 0.00}
  validates :bank_account, :presence => true
  validates :source_of_fund, :presence => true



  protected
  
  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end


end