module ApplicationHelper


 
  NUMBER_WORDS_HASH = {
    1 => 'One', 2 => 'Two',  3 => 'Three', 4 => 'Four', 5 => 'Five', 6 => 'Six', 7 => 'Seven', 8 => 'Eight', 9 => 'Nine', 10 => 'Ten',
    11 => 'Eleven', 12 => 'Twelve',  13 => 'Thirteen', 14 => 'Fourteen', 15 => 'Fifteen', 16 => 'Sixteen', 17 => 'Seventeen', 18 => 'Eighteen', 19 => 'Nineteen', 20 => 'Twenty',
    21 => 'Twenty-One', 22 => 'Twenty-Two',  23 => 'Twenty-Three', 24 => 'Twenty-Four', 25 => 'Twenty-Five', 26 => 'Twenty-Six', 27 => 'Twenty-Seven', 28 => 'Twenty-Eight', 29 => 'Twenty-Nine', 30 => 'Thirty',
    31 => 'Thirty-One', 32 => 'Thirty-Two', 33 => 'Thirty-Three', 34 => 'Thirty-Four', 35 => 'Thirty-Five', 36 => 'Thirty-Six', 37 => 'Thirty-Seven', 38 => 'Thirty-Eight', 39 => 'Thirty-Nine', 40 =>'Fourty',
    41 => 'Fourty-One', 42 => 'Fourty-Two', 43 => 'Fourty-Three', 44 => 'Fourty-Four', 45 => 'Fourty-Five', 46 => 'Fourty-Six', 47 => 'Fourty-Seven', 48 => 'Fourty-Eight', 49 => 'Fourty-Nine', 50 => 'Fifty',
    51 => 'Fifty-One', 52 => 'Fifty-Two', 53 => 'Fifty-Three', 54 => 'Fifty-Four', 55 => 'Fifty-Five', 56 => 'Fifty-Six', 57 => 'Fifty-Seven', 58 => 'Fifty-Eight', 59 => 'Fifty-Nine', 60 => 'Sixty',
    61 => 'Sixty-One', 62 => 'Sixty-Two', 63 => 'Sixty-Three', 64 => 'Sixty-Four', 65 => 'Sixty-Five', 66 => 'Sixty-Six', 67 => 'Sixty-Seven', 68 => 'Sixty-Eight', 69 => 'Sixty-Nine', 70 => 'Seventy',
    71 => 'Seventy-One', 72 => 'Seventy-Two', 73 => 'Seventy-Three', 74 => 'Seventy-Four', 75 => 'Seventy-Five', 76 => 'Seventy-Six', 77 => 'Seventy-Seven', 78 => 'Seventy-Eight', 79 => 'Seventy-Nine', 80 => 'Eighty',
    81 => 'Eighty-One', 82 => 'Eighty-Two', 83 => 'Eighty-Three', 84 => 'Eighty-Four', 85 => 'Eighty-Five', 86 => 'Eighty-Six', 87 => 'Eighty-Seven', 88 => 'Eighty-Eight', 89 => 'Eighty-Nine', 90 => 'Ninety',    
    91 => 'Ninety-One', 92 => 'Ninety-Two', 93 => 'Ninety-Three', 94 => 'Ninety-Four', 95 => 'Ninety-Five', 96 => 'Ninety-Six', 97 => 'Ninety-Seven', 98 => 'Ninety-Eight', 99 => 'Ninety-Nine', 100 => 'One Hundred'
  }


  NUMBER_WORDS_SCALE = ['', 'Thousand', 'Million', 'Billion', 'Trillion', 'Quadrillion', 'Quintillion', 'Sextillion']


  def get_hundred_value(num)
    arr = num.to_i.to_s.reverse.scan(/.{1,2}/).map(&:reverse).reverse
    
    if arr.size == 1
      return NUMBER_WORDS_HASH[arr[0].to_i]
    else
      str = "#{NUMBER_WORDS_HASH[arr[0].to_i]} Hundred "
      str << "#{NUMBER_WORDS_HASH[arr[1].to_i]}"
      return str
    end
    
  end

   


  def number_to_words(num)
    n = num
    n = 0 if n.nil?
    str_amount = ("%.2f" % n)


    whole_part = str_amount.split('.')[0]
    whole_part_split = whole_part.reverse.scan(/.{1,3}/).map(&:reverse).reverse
    size = whole_part_split.size
    
    arr = []
    whole_part_split.reverse.each_with_index do |item, index|
      str = get_hundred_value(item.to_i)
      whole_part_str =  "#{str} #{NUMBER_WORDS_SCALE[index]}"
      arr << whole_part_str
    end


    whole_part_str = arr.reverse.join(' ')


    # generate the centavo part
    fraction_part = str_amount.split('.')[1]
    fraction_part_str = ""
    if fraction_part.to_i > 0
       fraction_part_str = " and #{NUMBER_WORDS_HASH[fraction_part.to_i]} Centavos"
    end

    
    return "#{whole_part_str} Pesos #{fraction_part_str}".split(/\s+/).join(' ')

  end




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
    #[['Worldwide Work', 'Worldwide Work'], ['Kingdom Hall Construction Worldwide', 'Kingdom Hall Construction Worldwide'], ['Local Congregation Expenses', 'Local Congregation Expenses']]
    [['Worldwide Work', 'Worldwide Work'], ['Local Congregation Expenses', 'Local Congregation Expenses']]
  end

  def bank_accounts_list
    lst = [['Checking Account', 'Checking Account'], ['Other Account', 'Other Account']]

    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       lst[0][0] = @accounting_period.checking_account_rename unless @accounting_period.checking_account_rename.blank?
       lst[1][0] = @accounting_period.other_account_name unless @accounting_period.other_account_name.blank?
    end

    return lst
  end

  def source_of_funds_list
    lst = [['Cash on Hand', 'Cash on Hand'], ['Checking Account', 'Checking Account'], ['Other Bank Account', 'Other Bank Account']]



    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       lst[1][0] = @accounting_period.checking_account_rename unless @accounting_period.checking_account_rename.blank?
       lst[2][0] = @accounting_period.other_account_name unless @accounting_period.other_account_name.blank?
    end

    return lst
  end


  def bank_account_display(val)

    if @accounting_period && (!@accounting_period.checking_account_rename.blank? || !@accounting_period.other_account_name.blank?)
       return @accounting_period.checking_account_rename if !@accounting_period.checking_account_rename.blank? && val == 'Checking Account'
       return @accounting_period.other_account_name if !@accounting_period.other_account_name.blank? && val == 'Other Bank Account'
       return @accounting_period.other_account_name if !@accounting_period.other_account_name.blank? && val == 'Other Account'
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
