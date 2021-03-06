module PdfReportGenerator

module AccountSheet

class AccountSheetTransaction

  attr_accessor :date, :transaction_description, :tc, :receipt_in, :receipt_out, :checking_in, :checking_out, :other_in, :other_out
  attr_accessor :notes 

  
  def initialize args = {}
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    
    @notes = []   

    

  end 

  def add_note! note, amount
    @notes << AccountSheetTransactionNote.new(:note => note, :amount => amount)
  end

  


end


end

end
