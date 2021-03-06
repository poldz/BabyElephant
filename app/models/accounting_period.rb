require 'fileutils'

class AccountingPeriod < ActiveRecord::Base
  belongs_to :user
  belongs_to :account

  has_many :receipts
  has_many :bank_deposits
  has_many :bank_withdrawals
  has_many :bank_interests
  has_many :bank_taxes
  has_many :bank_penalties
  has_many :bank_fees
  has_many :bank_other_transactions

  has_many :expenses
  has_many :remittances


  validates :date, :presence => true, :uniqueness => {:scope => :account_id, :message => "Accounting Period Aready Exists"}

  before_validation :set_user
  before_validation :set_date

  def current_total_worldwide_work
    total = 0.00
    if self.receipts && !self.receipts.empty?
      self.receipts.each do |r|
        total += r.worldwide_work.to_f.round(2)
        total += r.other_1_amount.to_f.round(2) if r.other_1_for == 'Worldwide Work'
        total += r.other_2_amount.to_f.round(2) if r.other_2_for == 'Worldwide Work'
        
      end
    end
    return total.to_f.round(2)
  end

  def current_total_kingdom_hall_construction_worldwide
    total = 0.00
    if self.receipts && !self.receipts.empty?
      self.receipts.each do |r|
        total += r.kingdom_hall_construction_worldwide.to_f.round(2)
        total += r.other_1_amount.to_f.round(2) if r.other_1_for == 'Kingdom Hall Construction Worldwide'
        total += r.other_2_amount.to_f.round(2) if r.other_2_for == 'Kingdom Hall Construction Worldwide'
        
      end
    end
    return total.to_f.round(2)
  end

  def current_total_local_congregation_expenses
    total = 0.00
    if self.receipts && !self.receipts.empty?
      self.receipts.each do |r|
        total += r.local_congregation_expenses.to_f.round(2)
        total += r.other_1_amount.to_f.round(2) if r.other_1_for == 'Local Congregation Expenses'
        total += r.other_2_amount.to_f.round(2) if r.other_2_for == 'Local Congregation Expenses'
        
      end
    end
    return total.to_f.round(2)
  end

  def total_bank_funds_at_beginning_of_month
    (self.checking_balance_forward.to_f.round(2) + other_account_balance_forward.to_f.round(2)).to_f.round(2)    
  end

  def current_total_bank_deposits
    self.bank_deposits.sum(:amount).round(2)
  end

  def current_total_bank_withdrawals
    self.bank_withdrawals.sum(:amount).round(2)
  end

  def current_total_bank_interests
    self.bank_interests.sum(:amount).round(2)
  end

  def current_total_bank_taxes
    self.bank_taxes.sum(:amount).round(2)
  end

  def current_total_contributions
    current_total_worldwide_work + current_total_kingdom_hall_construction_worldwide + current_total_local_congregation_expenses
  end

  def current_total_bank_balance
    (total_bank_funds_at_beginning_of_month + current_total_bank_deposits + current_total_bank_interests - current_total_bank_withdrawals - current_total_bank_taxes).round(2)
  end

  def current_total_bank_withdrawals_minus_exp_rem
    total = 0.0

    self.bank_withdrawals.each do |w|
       total += w.amount
       total -= w.expenses.sum(:amount)
       total -= w.remittances.sum(:amount)

    end


    return total.round(2)
  end


  # current for receipts undeposited

  def current_total_receipts_undeposited
    total = 0.00
    total += self.receipts_balance_forward
    total += self.receipts.sum(:total)
    total += current_total_bank_withdrawals_minus_exp_rem
    total -= current_total_bank_deposits
    total -= self.expenses.where('source_of_fund = ?', 'Cash on Hand').sum(:amount)
    total -= self.remittances.where('source_of_fund = ?', 'Cash on Hand').sum(:amount)
    return total.round(2)
  end


  # current for checking account

  def current_total_checking_balance
    total = 0.00
    total += self.checking_balance_forward
    total += self.bank_deposits.where('bank_account = ?', 'Checking Account').sum(:amount)
    total += self.bank_interests.where('bank_account = ?', 'Checking Account').sum(:amount)
    total += self.bank_other_transactions.where('bank_account = ? and transaction_type = ?', 'Checking Account', 'Debit').sum(:amount)
    

    total -= self.bank_taxes.where('bank_account = ?', 'Checking Account').sum(:amount)
    total -= self.bank_withdrawals.where('bank_account = ?', 'Checking Account').sum(:amount)
    total -= self.bank_penalties.where('bank_account = ?', 'Checking Account').sum(:amount)
    total -= self.bank_fees.where('bank_account = ?', 'Checking Account').sum(:amount)
    total -= self.bank_other_transactions.where('bank_account = ? and transaction_type = ?', 'Checking Account', 'Credit').sum(:amount)
    
   
    return total.round(2)
  end


  # current for other account
  def current_total_other_account_balance
    total = 0.00
    total += self.other_account_balance_forward
    total += self.bank_deposits.where('bank_account = ?', 'Other Account').sum(:amount)
    total += self.bank_interests.where('bank_account = ?', 'Other Account').sum(:amount)
    total += self.bank_other_transactions.where('bank_account = ? and transaction_type = ?', 'Other Account', 'Debit').sum(:amount)


    total -= self.bank_taxes.where('bank_account = ?', 'Other Account').sum(:amount)
    total -= self.bank_withdrawals.where('bank_account = ?', 'Other Account').sum(:amount)
    total -= self.bank_penalties.where('bank_account = ?', 'Other Account').sum(:amount)
    total -= self.bank_fees.where('bank_account = ?', 'Other Account').sum(:amount)
    total -= self.bank_other_transactions.where('bank_account = ? and transaction_type = ?', 'Other Account', 'Credit').sum(:amount)
    
   
    return total.round(2)

  end

  def current_total_funds
    total = 0.00
    total += current_total_receipts_undeposited
    total += current_total_checking_balance
    total += current_total_other_account_balance
    total.round(2)
  end



  def receipt_transactions 

    trans = []
    self.receipts.each do |r|
      if r.worldwide_work && r.worldwide_work > 0.00
        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => r.date,  :transaction_description => "SWW", :receipt_in => r.worldwide_work, :tc => 'W')       
      end

      if r.kingdom_hall_construction_worldwide && r.kingdom_hall_construction_worldwide > 0.00
        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => r.date,  :transaction_description => "SKHF", :receipt_in => r.kingdom_hall_construction_worldwide, :tc => 'K')       
      end

      if r.local_congregation_expenses && r.local_congregation_expenses > 0.00
        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => r.date,  :transaction_description => "LCE", :receipt_in => r.local_congregation_expenses, :tc => 'C')       
      end

      if r.other_1_amount && r.other_1_amount > 0.00
        other_1_desc = nil
        other_1_tc = nil

        if r.other_1_for == 'Local Congregation Expenses'
          other_1_desc = "LCE (#{r.other_1})"
          other_1_tc = 'C'
        elsif r.other_1_for == 'Worldwide Work'
          other_1_desc = "SWW (#{r.other_1})"
          other_1_tc = 'W'
        elsif r.other_1_for == 'Kingdom Hall Construction Worldwide'
          other_1_desc = "SKHF (#{r.other_1})"
          other_1_tc = 'K'
        end
  

        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => r.date,  :transaction_description => other_1_desc, :receipt_in => r.other_1_amount, :tc => other_1_tc)       
      end




      if r.other_2_amount && r.other_2_amount > 0.00
        other_2_desc = nil
        other_2_tc = nil

        if r.other_2_for == 'Local Congregation Expenses'
          other_2_desc = "LCE  (#{r.other_2})"
          other_2_tc = 'C'
        elsif r.other_2_for == 'Worldwide Work'
          other_2_desc = "SWW  (#{r.other_2})"
          other_2_tc = 'W'
        elsif r.other_2_for == 'Kingdom Hall Construction Worldwide'
          other_2_desc = "SKHF  (#{r.other_2})"
          other_2_tc = 'K'
        end
  

        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => r.date,  :transaction_description => other_2_desc, :receipt_in => r.other_2_amount, :tc => other_1_tc)       
      end     


    end

   return trans


  end

  def bank_deposit_transactions 
    trans = []
    bank_account_hash = {'Checking Account' => :checking_in, 'Other Account' => :other_in}

    self.bank_deposits.each do |d|
      

      unless d.display_with_withdrawal?
        source_of_fund_hash = {'Cash on Hand' => :receipt_out , 'Checking Account' => :checking_out, 'Other Bank Account' => :other_out}

        trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => d.date,  :transaction_description => 'Bank Deposit', bank_account_hash[d.bank_account] => d.amount, source_of_fund_hash[d.source_of_fund] => d.amount)       
      end

    end

    return trans

  end

  def bank_withdrawals_transactions 
    trans = []

    bank_account_hash = {'Checking Account' => :checking_out, 'Other Account' => :other_out}
    bank_account_hash_in = {'Checking Account' => :checking_in, 'Other Account' => :other_in}

    self.bank_withdrawals.each do |w|
      t = nil
      

      if w.display_with_deposit?
        # TODO: this does not support multiple deposits for bank transfer yet
        d = w.bank_deposits.first
        t = PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => w.date,  :transaction_description => 'Bank Transfer', bank_account_hash[w.bank_account] => w.amount, bank_account_hash_in[d.bank_account] => d.amount)  
      else       

        t = PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => w.date,  :transaction_description => 'Bank Withdrawal', bank_account_hash[w.bank_account] => w.amount)  

      end


      if w.note && !w.note.blank?
        t.add_note! w.note, nil
      end

      w.remittances.each do |r|
        t.add_note! r.name, r.amount
      end

      w.expenses.each do |e|
        t.add_note! e.name, e.amount
      end

      # add to transaction set
      trans << t     

    end

    return trans

  end

  def bank_other_transactions_transactions
    trans =[]

    bank_account_hash = {'Checking Account' => :checking_out, 'Other Account' => :other_out}
    bank_account_hash_in = {'Checking Account' => :checking_in, 'Other Account' => :other_in}

    self.bank_other_transactions.each do |bot|
      t = nil
  
      if bot.transaction_type == 'Debit'

        t = PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => bot.date,  :transaction_description => bot.description, bank_account_hash_in[bot.bank_account] => bot.amount)  

      elsif bot.transaction_type == 'Credit'
        t = PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => bot.date,  :transaction_description => bot.description, bank_account_hash[bot.bank_account] => bot.amount)  
 
      else
        raise "Error, this should not be here, transaction_type is unknown #{bot.transaction_type}"
      end

      trans << t
    end


    return trans

  end




  def bank_interests_transactions 
    trans = []

    self.bank_interests.each do |i|
      bank_account_hash = {'Checking Account' => :checking_in, 'Other Account' => :other_in}

      trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => i.date,  :transaction_description => 'Bank Interest', bank_account_hash[i.bank_account] => i.amount, :tc => "I")  

    end

    return trans

  end

  def bank_taxes_transactions 
    trans = []

    self.bank_taxes.each do |t|
      bank_account_hash = {'Checking Account' => :checking_out, 'Other Account' => :other_out}

      trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => t.date,  :transaction_description => 'Bank Withholding Tax', bank_account_hash[t.bank_account] => t.amount, :tc => "T")  

    end

    return trans

  end




  def cash_expenses_transactions
    trans = []

    self.expenses.where('source_of_fund = ?', 'Cash on Hand').each do |e|      
      trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => e.date,  :transaction_description => e.name, :receipt_out => e.amount)  
    end

    return trans

  end

  def cash_remittances_transactions
    trans = []

    self.remittances.where('source_of_fund = ?', 'Cash on Hand').each do |t|      
      trans << PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => t.date,  :transaction_description => t.name, :receipt_out => t.amount)  
    end

    return trans

  end


  def transactions
    trans = []

    trans += receipt_transactions 
    trans += bank_deposit_transactions
    trans += bank_interests_transactions 
    trans += bank_taxes_transactions 
    trans += bank_withdrawals_transactions 
    trans += bank_other_transactions_transactions
    trans += cash_expenses_transactions
    trans += cash_remittances_transactions

    
    #self.bank_penalties
    #self.bank_fees
    #self.bank_other_transactions

    #self.expenses
    #self.remittances

    return trans.sort{|a, b| a.date <=> b.date}

    

  end

  def get_account_sheet

     act_sheet = PdfReportGenerator::AccountSheet::AccountSheet.new

     act_sheet.congregation_or_circuit = self.account.account_name
     act_sheet.city = self.account.city_or_town
     act_sheet.province_or_state = self.account.province_or_state
     act_sheet.date = date.beginning_of_month
     
     act_sheet.checking_account_name = checking_account_rename
     act_sheet.other_account_name = other_account_name
     
     act_sheet.receipts_balance_forward = receipts_balance_forward

     act_sheet.checking_balance_forward = checking_balance_forward

     act_sheet.other_balance_forward = other_account_balance_forward

     transactions.each do |trans|
       act_sheet.add_transaction! trans
     end


     return act_sheet

  end

  def get_monthly_congregation_accounts_report



    rep = PdfReportGenerator::MonthlyCongregationAccountsReport::MonthlyCongregationAccountsReport.new
    rep.date = date.beginning_of_month
    rep.congregation = self.account.account_name
    rep.account_servant_name = self.account.account_servant_name
    rep.funds_at_beginning_of_month = total_funds_at_bom

    rep.for_the_worldwide_work = remittances.where('remittance_type = ?', 'Worldwide Work').sum(:amount)
    rep.for_kingdom_hall_construction_worldwide = remittances.where('remittance_type = ?', 'Kingdom Hall Construction Worldwide').sum(:amount)

    #rep.other_receipt = "the quick bronwn fox jumps over 111"
    #rep.other_receipt_amount = 11111.11

    #rep.other_disbursement = "the quick brown fox jumps over 222"
    #rep.other_disbursement_amount = 2222.22
    

    # Add Receipts
    rep.add_reciepts! "From Local Congregation Expense Box", current_total_local_congregation_expenses
    total_interests = bank_interests.sum(:amount)
    rep.add_reciepts!("Bank Interest", total_interests) if total_interests and total_interests > 0.00


    bank_other_transactions.where("transaction_type = ?", 'Debit').each do |bot|
      rep.add_reciepts! bot.description, bot.amount
    end


    # Add Expenditures

    remittances.where('remittance_type not in (?)', ['Worldwide Work', 'Kingdom Hall Construction Worldwide']).each do |r|
      rep.add_expenditure! r.name, r.amount
    end


    expenses.each do |e|
      rep.add_expenditure! e.name, e.amount
    end


    total_taxes = bank_taxes.sum(:amount)
    rep.add_expenditure! "Bank Withholding Tax", total_taxes if total_taxes and total_taxes > 0.00


    bank_other_transactions.where("transaction_type = ?", 'Credit').each do |bot|
      rep.add_expenditure! bot.description, bot.amount
    end


    # Add Congregation Funds Reserved For Special Purpose
    #rep.add_funds_reserved_for_special_purpose! "test Funds Reserved for Sp Purp. 1", 11111.11

    return rep

  end


  def get_remittance_form

    rem = PdfReportGenerator::RemittanceForm::RemittanceForm.new
  

    rem.is_congregation = true if self.account.account_type == 'Congregation'
    rem.is_circuit = true if self.account.account_type == 'Circuit'
    rem.is_kh_operating_committee = true if self.account.account_type == 'KH Operating Commitee'


    rem.name_of_congregation = self.account.account_name
    rem.congregation_number = self.account.account_number
    rem.date = DateTime.now
    rem.city_or_town = self.account.city_or_town
    rem.province = self.account.province_or_state
  
    rem.worldwide_work = remittances.where('remittance_type = ?', 'Worldwide Work').sum(:amount)
    rem.kingdom_hall_construction_worldwide = remittances.where('remittance_type = ?', 'Kingdom Hall Construction Worldwide').sum(:amount)


    rem.branch_owned_kingdom_hall = remittances.where('remittance_type = ?', 'Branch-owned Kingdom Hall').sum(:amount)
    rem.kingdom_hall_loans_repayment = remittances.where('remittance_type = ?', 'Kingdom Hall Loans Repayment').sum(:amount)
    rem.funds_on_deposit = remittances.where('remittance_type = ?', 'Funds-on-deposit').sum(:amount)
    rem.kingdom_hall_assistance_arrangement = remittances.where('remittance_type = ?', 'Kingdom Hall Assistance Arrangement').sum(:amount)
    rem.relief_fund = remittances.where('remittance_type = ?', 'Relief Fund').sum(:amount)
    rem.circuit_fund = remittances.where('remittance_type = ?', 'Circuit Fund').sum(:amount)
    rem.assembly_hall_fund = remittances.where('remittance_type = ?', 'Assembly Hall Fund').sum(:amount)


    rem.others_1 = remittances.where('remittance_type = ?', 'Others 1').map(&:name).join(', ')
    rem.others_1_amount = remittances.where('remittance_type = ?', 'Others 1').sum(:amount)
    rem.others_2 = remittances.where('remittance_type = ?', 'Others 2').map(&:name).join(', ')
    rem.others_2_amount = remittances.where('remittance_type = ?', 'Others 2').sum(:amount)

    rem.account_servant_name = self.account.account_servant_name
    rem.secritary_name = self.account.secritary_name

    return rem

  end


  def report_filename
    filename = "#{account.id}_#{account.account_number}_#{account.account_name}-#{self.id}_#{date.strftime("%b_%Y")}.pdf"    
    fullfilename = File.join(Rails.root, 'public', 'reports', filename)
    return fullfilename
  end




  def generate_report!

    act_sheet = get_account_sheet
    monthly_report = get_monthly_congregation_accounts_report
    remittance_form = get_remittance_form
    

    

    


    Prawn::Document.generate(report_filename, :template => act_sheet.template_file) do |pdf|      
      act_sheet.render_to_page!(pdf, true)
      monthly_report.render_to_page!(pdf, false)
      remittance_form.render_to_page!(pdf, false)
    end

    return report_filename


  end

  private

  def set_user
    self.user = self.account.user
  end

  def set_date
    self.date = self.date.beginning_of_month if self.date
  end
end
