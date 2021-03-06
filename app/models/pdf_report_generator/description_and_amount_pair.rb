

module PdfReportGenerator


class DescriptionAndAmountPair
  attr_accessor :name, :amount

  
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

end



end
