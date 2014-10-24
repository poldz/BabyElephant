class Receipt < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :accounting_period


  before_validation :set_account_and_user
  before_validation :set_total

  validates :other_1_amount, :presence => true, :numericality => {:greater_than => 0.00,  :if => :other_1_for_required?}
  validates :other_1_for, :presence => { :if => :other_1_for_required? }

  validates :other_2_amount, :presence => true, :numericality => {:greater_than => 0.00,  :if => :other_2_for_required?}
  validates :other_2_for, :presence => { :if => :other_2_for_required? }


  validates :worldwide_work, :presence => true, :numericality => true, :allow_nil => true
  validates :kingdom_hall_construction_worldwide, :presence => true, :numericality => true, :allow_nil => true
  validates :local_congregation_expenses,	 :presence => true, :numericality => true, :allow_nil => true

  
  protected


  def other_1_for_required?
    return true if !other_1.blank?
    return true if other_1_amount > 0.00
    return false
  end

  def other_2_for_required?
    return true if !other_2.blank?
    return true if other_2_amount > 0.00
    return false
  end

  def set_account_and_user
   self.account = self.accounting_period.account
   self.user = self.accounting_period.user
  end

  def set_total
    self.total = self.worldwide_work.to_f + self.kingdom_hall_construction_worldwide.to_f + self.local_congregation_expenses.to_f + self.other_1_amount.to_f + self.other_2_amount.to_f

  end



end
