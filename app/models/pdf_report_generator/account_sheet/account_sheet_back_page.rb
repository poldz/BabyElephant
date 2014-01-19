

module PdfReportGenerator

module AccountSheet

class AccountSheetBackPage < AccountSheetPageBase
  attr_accessor :congregation_or_circuit, :city, :province_or_state, :other_account_name
  #attr_accessor :account_sheet_details

  SHEET_START_TOP = 35




  def render_to_page!(pdf_object, first_page = false)



   # :checking_account_name
   if @checking_account_name && !@checking_account_name.blank?
      text_box(pdf_object, 352, 3, @checking_account_name, :size => 6, :height => 20)
      text_box(pdf_object, 356, 14, "XXXXXXXXX", :size => 6, :height => 20)
   end

   # :other_account_name
   if @other_account_name && !@other_account_name.blank?
      text_box(pdf_object, 480, 13, @other_account_name, :size => 6, :height => 20)
   end

   


   sheet_money_box(pdf_object, 228, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_receipt_in))
   sheet_money_box(pdf_object, 282, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_receipt_out))
   sheet_money_box(pdf_object, 336, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_checking_in))
   sheet_money_box(pdf_object, 388, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_checking_out))
   sheet_money_box(pdf_object, 442, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_other_in))
   sheet_money_box(pdf_object, 496, SHEET_START_TOP, (self.previous_page.nil? ? 0.00 : self.previous_page.total_other_out))
   

   # render account sheet details
   @account_sheet_details.compact.each_with_index do |detail, index|
     render_account_sheet_detail!(pdf_object, index+1, detail)
   end

   # render totals
   sheet_money_box(pdf_object, 228, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_receipt_in)
   sheet_money_box(pdf_object, 282, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_receipt_out)
   sheet_money_box(pdf_object, 336, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_checking_in)
   sheet_money_box(pdf_object, 388, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_checking_out)
   sheet_money_box(pdf_object, 442, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_other_in)
   sheet_money_box(pdf_object, 496, (SHEET_START_TOP + ((number_of_lines + 1) * 11.3)), self.total_other_out)


   if is_last_page?
     render_account_sheet_reconciliation!(pdf_object)   
   end

  end


  def render_account_sheet_reconciliation!(pdf_object)


    # FOR MONTH ENDING:
    text_box(pdf_object, 123, 358.9, "#{self.month}, #{self.year}", :size => 10, :height => 20)

    # RECEIPTS:
    
    money_box(pdf_object, 103, 393.9, self.receipts_balance_forward)
    money_box(pdf_object, 103, 404.0, self.total_receipt_in)
    money_box(pdf_object, 103, 415, self.total_receipt_out)
    money_box(pdf_object, 203, 426, self.receipts_ending_balance)



    # CHECKING ACCOUNT:
    checking_distance = 80
    money_box(pdf_object, 103, 393.9 + checking_distance, self.checking_balance_forward)
    money_box(pdf_object, 103, 404.0 + checking_distance, self.total_checking_in)
    money_box(pdf_object, 103, 415 + checking_distance, self.total_checking_out)
    money_box(pdf_object, 203, 426 + checking_distance, self.checking_ending_balance)



   # :checking_account_name
   if @checking_account_name && !@checking_account_name.blank?
      text_box(pdf_object, -12, 376.9 + checking_distance, @checking_account_name, :size => 8, :height => 20)
      text_box(pdf_object, -13, 384.9 + checking_distance, "XXXXXXXXX", :size => 8, :height => 20)
   end





    # OTHER ACCOUNT:
    other_distance = 180
    money_box(pdf_object, 103, 393.9 + other_distance, self.other_balance_forward)
    money_box(pdf_object, 103, 404.0 + other_distance, self.total_other_in)
    money_box(pdf_object, 103, 415 + other_distance, self.total_other_out)
    money_box(pdf_object, 203, 426 + other_distance, self.other_ending_balance)


   # :other_account_name
   if @other_account_name && !@other_account_name.blank?
      text_box(pdf_object, 22, 381.9 + other_distance, @other_account_name, :size => 8, :height => 20)
   end

   


    # TOTAL FUNDS ON HAND AT END OF MONTH
    money_box(pdf_object, 203, 449 + other_distance, self.total_funds_on_hand)


   ###############################
   # OBLIGATIONS AT END OF MONTH #
   ###############################

   # CURRENT   
   if @obligations_at_eom_current
      @obligations_at_eom_current.compact.each_with_index do |obligation, i|
        text_box(pdf_object, 286, 400.9 + (i * 11.3), obligation.name)
        money_box(pdf_object, 427, 400.9 + (i * 11.3), obligation.amount)
        
      end

      money_box(pdf_object, 491, 400.9 + (11 * 11.3), self.total_obligations_at_eom_current)

   end


   # LONG TERM
   if @obligations_at_eom_long_term
      @obligations_at_eom_long_term.compact.each_with_index do |obligation, i|
        text_box(pdf_object, 286, 574 + (i * 11.3), obligation.name)
        money_box(pdf_object, 427, 574 + (i * 11.3), obligation.amount)
        
      end

      money_box(pdf_object, 491, 578 + (8 * 11.3), self.total_obligations_at_eom_long_term)     
   end
    
    

  end


  
  def template_file
    #"#{Rails.root}/app/assets/pdf/AccountSheetBack.pdf"
    File.join(Rails.root, 'app', 'assets', 'pdf', 'AccountSheetBack.pdf')
  end


  def number_of_lines
    22
  end


  private


  # render account sheet detail
  def render_account_sheet_detail!(pdf_obj, line, sheet_item)

    if sheet_item.is_note?
      if sheet_item.note_amount.nil?
        text_box(pdf_obj, 30, (SHEET_START_TOP + (line * 11.3)), "#{sheet_item.note}", :size => 6)
      else
        text_box(pdf_obj, 30, (SHEET_START_TOP + (line * 11.3)), "#{sheet_item.note} (#{money_format(sheet_item.note_amount)})", :size => 6)
      end
    else
      # transaction date
      if sheet_item.date && (sheet_item.date.month == date.month && sheet_item.date.year == date.year)
        text_box(pdf_obj, -10, (SHEET_START_TOP + (line * 11.3)), sheet_item.date.day.to_s, :width => 10)
      elsif sheet_item.date
        text_box(pdf_obj, -13, (SHEET_START_TOP + (line * 11.3)), "#{sheet_item.date.month.to_s}/#{sheet_item.date.day.to_s}", :width => 20) 
      end

      # transaction description
      text_box(pdf_obj, 10, (SHEET_START_TOP + (line * 11.3)), sheet_item.transaction_description)

      # transaction code
      text_box(pdf_obj, 220, (SHEET_START_TOP + (line * 11.3)), sheet_item.tc)

      sheet_money_box(pdf_obj, 228, (SHEET_START_TOP + (line * 11.3)), sheet_item.receipt_in)
      sheet_money_box(pdf_obj, 282, (SHEET_START_TOP + (line * 11.3)), sheet_item.receipt_out)
      sheet_money_box(pdf_obj, 336, (SHEET_START_TOP + (line * 11.3)), sheet_item.checking_in)
      sheet_money_box(pdf_obj, 388, (SHEET_START_TOP + (line * 11.3)), sheet_item.checking_out)
      sheet_money_box(pdf_obj, 442, (SHEET_START_TOP + (line * 11.3)), sheet_item.other_in)
      sheet_money_box(pdf_obj, 496, (SHEET_START_TOP + (line * 11.3)), sheet_item.other_out)
    end




  end





end


end

end
