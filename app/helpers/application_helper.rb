module ApplicationHelper
  def remittance_type_list
    arr = []
    arr << ['Worldwide Work (From contribution box)', 'Worldwide Work']
    arr << ['Kingdom Hall Construction Worldwide (From contribution box)', 'Kingdom Hall Construction Worldwide']
    arr << ['Branch-owned Kingdom Hall (Resolution)', 'Branch-owned Kingdom Hall']
    arr << ['Kingdom Hall Loans Repayment', 'Kingdom Hall Loans Repayment']
    arr << ['Funds-on-deposit', 'Funds-on-deposit']
    arr << ['Kingdom Hall Assistance Arrangement (KHAA)', 'Kingdom Hall Assistance Arrangement']
    arr << ['Relief Fund', 'Relief Fund']
    arr << ['Circuit Fund', 'Circuit Fund']
    arr << ['Assembly Hall Fund', 'Assembly Hall Fund']
    arr << ['Others Line 1 (see Remittance Form)', 'Others 1']
    arr << ['Others Line 2 (see Remittance Form)', 'Others 2']
    return arr
  end

  def source_of_fund_list
    ['Cash on Hand', 'Withdrawal'] 
  end

  def contributions_for_list
    [['Worldwide Work', 'Worldwide Work'], ['Kingdom Hall Construction Worldwide', 'Kingdom Hall Construction Worldwide'], ['Local Congregation Expenses', 'Local Congregation Expenses']]
  end

  def bank_accounts_list
    lst = [['Checking Account', 'Checking Account'], ['Other Account', 'Other Account']]

    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       lst[0][0] = @accounting_period.checking_account_rename if @accounting_period.checking_account_rename
       lst[1][0] = @accounting_period.other_account_name if @accounting_period.other_account_name
    end

    return lst
  end

  def source_of_funds_list
    lst = [['Cash on Hand', 'Cash on Hand'], ['Checking Account', 'Checking Account'], ['Other Bank Account', 'Other Bank Account']]



    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       lst[1][0] = @accounting_period.checking_account_rename if @accounting_period.checking_account_rename
       lst[2][0] = @accounting_period.other_account_name if @accounting_period.other_account_name
    end

    return lst
  end


  def bank_account_display(val)

    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       return @accounting_period.checking_account_rename if @accounting_period.checking_account_rename && val == 'Checking Account'
       return @accounting_period.other_account_name if @accounting_period.other_account_name && val == 'Other Bank Account'
    end

    return val

  end

  def date_format(d)
    return "" if d.nil?
    return d.strftime("%b.%d,%Y")   
  
  end

  def money_format(a)
    return "0.00" if a.nil?
    return ("%.2f" % a)
  end

end
