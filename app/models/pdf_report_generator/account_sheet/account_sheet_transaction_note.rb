module PdfReportGenerator

module AccountSheet

class AccountSheetTransactionNote

  attr_accessor :note, :amount

  
  def initialize args = {}
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    

  end 

  


end


end

end
