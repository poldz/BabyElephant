

module PdfReportGenerator


module AccountSheet

class AccountSheetDetail
  attr_accessor :date, :transaction_description, :tc, :receipt_in, :receipt_out, :checking_in, :checking_out, :other_in, :other_out, :note, :note_amount, :totals_carried_forward

  
  def initialize args = {}
    @totals_carried_forward = false
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end


  def set_values! args = {}
    args.each do |k,v|
      #puts "item: @#{k} >>>>>>>>>>> #{v}"
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    return true
  end

  def is_note?
    return true if note && !note.blank?
    return false
  end

  def is_totals_carried_forward?
    return @totals_carried_forward == true
  end


end


end

end
