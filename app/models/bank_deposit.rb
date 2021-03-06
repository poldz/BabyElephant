class BankDeposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period
  belongs_to :bank_withdrawal


  before_validation :set_account_and_user
  before_validation :clear_withdrawal_if_cash_on_hand, :set_date

  validates :amount, :presence => true, :numericality => {:greater_than => 0.00}
  validates :bank_account, :presence => true
  validates :source_of_fund, :presence => true
  validates :bank_withdrawal_id, :presence => { :if => :withdrawal_required? }



  def is_from_bank_withdrawal?
    return true if self.source_of_fund == 'Withdrawal' && self.bank_withdrawal
  end

  def display_with_withdrawal?
    return true if self.bank_withdrawal && self.bank_withdrawal.display_with_deposit?
    return false
  end



  protected
  
  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end


  def withdrawal_required?
    return true if self.source_of_fund == 'Withdrawal'
    return false
  end

  def clear_withdrawal_if_cash_on_hand
    self.bank_withdrawal_id = nil if self.source_of_fund == 'Cash on Hand'
  end

  def set_date
    #if self.source_of_fund == 'Withdrawal'
    #  w = self.bank_withdrawal
    #  w = BankWithdrawal.find(self.bank_withdrawal_id)
    #  self.date = w.date if w
    #end
  end

end
