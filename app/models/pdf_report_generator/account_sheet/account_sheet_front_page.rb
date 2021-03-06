

module PdfReportGenerator

module AccountSheet

class AccountSheetFrontPage < AccountSheetPageBase
  
  #attr_accessor :account_sheet_details



  
  def template_file
    #"#{Rails.root}/app/assets/pdf/AccountSheetFront.pdf"
    File.join(Rails.root, 'app', 'assets', 'pdf', 'AccountSheetFront.pdf')
  end
	
  def number_of_lines
    return 52 if is_first_page?
    return 51 
  end






  def render_to_page!(pdf_object, first_page = false)   

   # :checking_account_name
   if @checking_account_name && !@checking_account_name.blank?
      text_box(pdf_object, 354, 33, @checking_account_name, :size => 6, :height => 20)
      text_box(pdf_object, 358, 44, "XXXXXXXXX", :size => 6, :height => 20)
   end

   # :other_account_name
   if @other_account_name && !@other_account_name.blank?
      text_box(pdf_object, 484, 44, @other_account_name, :size => 6, :height => 20)
   end


   text_box(pdf_object, 57, 6, self.congregation_or_circuit, :size => 12, :height => 20)
   text_box(pdf_object, 258, 6, "#{self.city}, #{self.province_or_state}", :size => 12, :height => 20)
   text_box(pdf_object, 444, 6, "#{self.month}, #{self.year}", :size => 12, :height => 20)
   

   # render account sheet details
   @account_sheet_details.compact.each_with_index do |detail, index|
     render_account_sheet_detail!(pdf_object, index+1, detail)
   end

   # render totals
   sheet_money_box(pdf_object, 228, (53.7 + (53 * 11.3)), self.total_receipt_in)
   sheet_money_box(pdf_object, 282, (54 + (53 * 11.3)), self.total_receipt_out)
   sheet_money_box(pdf_object, 336, (54 + (53 * 11.3)), self.total_checking_in)
   sheet_money_box(pdf_object, 390, (54 + (53 * 11.3)), self.total_checking_out)
   sheet_money_box(pdf_object, 444, (54 + (53 * 11.3)), self.total_other_in)
   sheet_money_box(pdf_object, 498, (54 + (53 * 11.3)), self.total_other_out)


   if is_last_page?
     act_sheet_back = AccountSheetBackPage.new :previous_page => self
     act_sheet_back.create_new_page!(pdf_object)
     act_sheet_back.render_to_page!(pdf_object)

   end

   

  end


  private


  # render account sheet detail
  def render_account_sheet_detail!(pdf_obj, line, sheet_item)

    if sheet_item.is_note?
      if sheet_item.note_amount.nil?
        text_box(pdf_obj, 30, (53.7 + (line * 11.3)), "#{sheet_item.note}", :size => 6)
      else
        text_box(pdf_obj, 30, (53.7 + (line * 11.3)), "#{sheet_item.note} (#{money_format(sheet_item.note_amount)})", :size => 6)
      end
    else
      # transaction date
      if sheet_item.date && (sheet_item.date.month == date.month && sheet_item.date.year == date.year)
        text_box(pdf_obj, -10, (53.7 + (line * 11.3)), sheet_item.date.day.to_s, :width => 10)
      elsif sheet_item.date
        text_box(pdf_obj, -13, (53.7 + (line * 11.3)), "#{sheet_item.date.month.to_s}/#{sheet_item.date.day.to_s}", :width => 20)
      end

      # transaction description
      text_box(pdf_obj, 10, (53.7 + (line * 11.3)), sheet_item.transaction_description)

      # transaction code
      text_box(pdf_obj, 220, (53.7 + (line * 11.3)), sheet_item.tc)

      sheet_money_box(pdf_obj, 228, (53.7 + (line * 11.3)), sheet_item.receipt_in)
      sheet_money_box(pdf_obj, 282, (54 + (line * 11.3)), sheet_item.receipt_out)
      sheet_money_box(pdf_obj, 336, (54 + (line * 11.3)), sheet_item.checking_in)
      sheet_money_box(pdf_obj, 390, (54 + (line * 11.3)), sheet_item.checking_out)
      sheet_money_box(pdf_obj, 444, (54 + (line * 11.3)), sheet_item.other_in)
      sheet_money_box(pdf_obj, 498, (54 + (line * 11.3)), sheet_item.other_out)
    end




  end

end

end

end
