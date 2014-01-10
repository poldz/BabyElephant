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
    ['Checking Account', 'Other Account']
  end

  def source_of_funds_list
    ['Cash on Hand', 'Checking Account', 'Other Bank Account']
  end

end
