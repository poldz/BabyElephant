class BankTax < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period

  before_validation :set_account_and_user

  validates :amount, :presence => true, :numericality => {:greater_than => 0.00}
  validates :bank_account, :presence => true



  protected
  
  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end
end
