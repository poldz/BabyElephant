

module PdfReportGenerator


module AccountSheet



class AccountSheetPageBase < PdfReportGenerator::PDFRenderable

  attr_accessor :congregation_or_circuit, :city, :province_or_state, :other_account_name, :checking_account_name
  attr_accessor :receipts_balance_forward, :checking_balance_forward, :other_balance_forward

  attr_accessor :account_sheet_details


  attr_accessor :date, :previous_page, :next_page

  attr_accessor :obligations_at_eom_current, :obligations_at_eom_long_term



  
  def initialize args = {}


    @item_counter = 1
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    @obligations_at_eom_current = []
    @obligations_at_eom_long_term = []
    

    if @previous_page
      @previous_page.next_page = self
    end


    @account_sheet_details = []

    # copy needed values from previous page
    
    if @previous_page
      @date = @previous_page.date
      @congregation_or_circuit = @previous_page.congregation_or_circuit
      @city = @previous_page.city
      @province_or_state = @previous_page.province_or_state
      @other_account_name = @previous_page.other_account_name
      @checking_account_name = @previous_page.checking_account_name
      @receipts_balance_forward = @previous_page.receipts_balance_forward
      @checking_balance_forward = @previous_page.checking_balance_forward
      @other_balance_forward = @previous_page.other_balance_forward

      @obligations_at_eom_current = []
      @obligations_at_eom_current = @previous_page.obligations_at_eom_current
      @obligations_at_eom_long_term = []
      @obligations_at_eom_long_term = @previous_page.obligations_at_eom_long_term

      if !is_first_page? && self.is_a?(AccountSheetFrontPage)
        @account_sheet_details << AccountSheetDetail.new(:totals_carried_forward => true,
        :transaction_description => "Totals Carried Forward",
        :receipt_in => @previous_page.total_receipt_in,
        :receipt_out => @previous_page.total_receipt_out,
        :checking_in => @previous_page.total_checking_in,
        :checking_out => @previous_page.total_checking_out,
        :other_in => @previous_page.total_other_in,
        :other_out => @previous_page.total_other_out) 
      end
      
    end

    
    
    number_of_lines.times { @account_sheet_details << AccountSheetDetail.new(args) }

    

    

  end


  def is_last_page?
    @next_page.nil?
  end

  def is_first_page?
    @previous_page.nil?
  end 

  def can_add_details?
    @item_counter <= number_of_lines
  end

  

  def add_detail!(args = {})
    retval = set_sheet_detail!(@item_counter, args)
    @item_counter += 1
    return retval
  end



  def set_sheet_detail!(item_number, args = {})
    
    sw = 1
    sw = 0 if !is_first_page? && self.is_a?(AccountSheetFrontPage)

    if @account_sheet_details[item_number-sw]
      @account_sheet_details[item_number-sw].set_values! args
      return true      
    else
      return false
    end

  end
	
  def number_of_lines
    raise 'implement this'
  end




  def month
    @date.strftime("%B")
  end

  def year
    @date.year.to_s
  end






  def total_receipt_in
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.receipt_in.nil? }.sum(&:receipt_in).round(2)
    t += previous_page.total_receipt_in if previous_page
    return t
  end


  def total_receipt_out    
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.receipt_out.nil? }.sum(&:receipt_out).round(2)
    t += previous_page.total_receipt_out if previous_page
    return t
  end

  def receipts_ending_balance
    ((receipts_balance_forward + total_receipt_in) - total_receipt_out).round(2)
  end

  def total_checking_in
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.checking_in.nil? }.sum(&:checking_in).round(2)
    t += previous_page.total_checking_in if previous_page
    return t
  end

  def total_checking_out
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.checking_out.nil? }.sum(&:checking_out).round(2)
    t += previous_page.total_checking_out if previous_page
    return t
  end



  def checking_ending_balance
    ((checking_balance_forward + total_checking_in) - total_checking_out).round(2)
  end

  def total_other_in
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.other_in.nil? }.sum(&:other_in).round(2)
    t += previous_page.total_other_in if previous_page
    return t
  end


  def total_other_out
    t = @account_sheet_details.select{|d| !d.is_totals_carried_forward? && !d.other_out.nil? }.sum(&:other_out).round(2)
    t += previous_page.total_other_out if previous_page
    return t
  end

  def other_ending_balance
    ((other_balance_forward + total_other_in) - total_other_out).round(2)
  end


  def total_funds_on_hand
    (receipts_ending_balance + checking_ending_balance + other_ending_balance).round(2)
  end


  def total_obligations_at_eom_current
    t = @obligations_at_eom_current.compact.select{|d| !d.amount.nil? }.sum(&:amount).round(2)
    return t
  end
  
  def total_obligations_at_eom_long_term
    t = @obligations_at_eom_long_term.compact.select{|d| !d.amount.nil? }.sum(&:amount).round(2)
    return t
  end


  

  


end


end

end
