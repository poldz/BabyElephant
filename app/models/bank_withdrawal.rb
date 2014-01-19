class BankWithdrawal < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period

  has_many :expenses
  has_many :remittances

  has_many :bank_deposits


  attr_accessible :amount, :bank_account, :created_by_id, :date, :note

  before_validation :set_account_and_user

  validates :amount, :presence => true, :numericality => {:greater_than => 0.00}
  validates :bank_account, :presence => true

  def display_name
    "[#{date}] #{bank_account} (#{amount})"
  end

  def is_deposited?
    return false if self.bank_deposits.blank?
    return true    
  end

  def is_all_deposit_same_day?
    return false unless is_deposited?
  
    self.bank_deposits.each do |d|
      return false unless is_same_day?(d)
    end

    return true  
  end


  def display_with_deposit?
    return is_deposited? && is_all_deposit_same_day?
  end


  protected
  
  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end

  private

  def is_same_day?(d)
     return false unless d
     return false unless d.date
     return false unless date

     return false if date.year != d.date.year
     return false if date.month != d.date.month
     return false if date.day != d.date.day


     return true

  end

end
