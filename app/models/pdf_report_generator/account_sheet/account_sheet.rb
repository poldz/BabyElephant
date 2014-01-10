

module PdfReportGenerator

module AccountSheet

class AccountSheet < PdfReportGenerator::PDFRenderable

  attr_accessor :date, :congregation_or_circuit, :city, :province_or_state, :other_account_name, :checking_account_name
  attr_accessor :receipts_balance_forward, :checking_balance_forward, :other_balance_forward

  attr_accessor :account_sheet_details


  

  attr_accessor :obligations_at_eom_current, :obligations_at_eom_long_term



  
  def initialize args = {}
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    @obligations_at_eom_current = []
    @obligations_at_eom_long_term = []
    @pages = []   

    

  end


  def add_obligations_at_eom_current!(name, amount) 
    @obligations_at_eom_current << PdfReportGenerator::DescriptionAndAmountPair.new(:name => name, :amount => amount)
  end

  def add_obligations_at_eom_long_term!(name, amount)
    @obligations_at_eom_long_term << PdfReportGenerator::DescriptionAndAmountPair.new(:name => name, :amount => amount)
  end



  def template_file
    return current_page.template_file if @pages.empty?
    return @pages.first.template_file
  end




  def render_to_page!(pdf, first_page = false)

    current = current_page


    @pages.each_with_index do |page, i|
      page.create_new_page!(pdf) if !(first_page && i == 0)
      page.render_to_page!(pdf)

    end

  end

  def add_transaction!(t)
    if t

      add_detail! :date => t.date, 
                  :transaction_description => t.transaction_description, 
                  :tc => t.tc, 
                  :receipt_in => t.receipt_in, 
                  :receipt_out => t.receipt_out, 
                  :checking_in => t.checking_in, 
                  :checking_out => t.checking_out, 
                  :other_in => t.other_in, 
                  :other_out => t.other_out

      if t.notes
         t.notes.each do |n|
           add_detail! :note => n.note, :note_amount => n.amount
         end
      end

    end
  end



  private




  def add_detail!(args = {})

    unless current_page.can_add_details?
      create_page!
    end

    return current_page.add_detail!(args)
  end



  def create_first_page!

     page = AccountSheetFrontPage.new :previous_page => nil

     page.congregation_or_circuit = self.congregation_or_circuit
     page.city = self.city
     page.province_or_state = self.province_or_state
     page.date = self.date     
     page.checking_account_name = self.checking_account_name
     page.other_account_name = self.other_account_name     
     page.receipts_balance_forward = self.receipts_balance_forward
     page.checking_balance_forward = self.checking_balance_forward
     page.other_balance_forward = self.other_balance_forward
     page.obligations_at_eom_current = self.obligations_at_eom_current
     page.obligations_at_eom_long_term = self.obligations_at_eom_long_term
     @pages << page

  end


  def current_page
    create_page! if @pages.empty?
    return @pages.last
  end





  def create_page!
     
    

    if @pages.empty?
      create_first_page!
    elsif (@pages.size % 2) == 1
      page = AccountSheetBackPage.new :previous_page => @pages.last
      @pages << page

    elsif (@pages.size % 2) == 0
      page = AccountSheetFrontPage.new :previous_page => @pages.last
      @pages << page

    end


  end


  
  




  

  


end


end

end
