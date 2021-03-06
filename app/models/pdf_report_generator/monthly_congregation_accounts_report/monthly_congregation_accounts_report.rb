

module PdfReportGenerator

module MonthlyCongregationAccountsReport

class MonthlyCongregationAccountsReport < PdfReportGenerator::PDFRenderable

  attr_accessor :date, :congregation, :account_servant_name, :funds_at_beginning_of_month


  

  attr_accessor :reciepts, :expenditures, :funds_reserved_for_special_purposes

  attr_accessor :for_the_worldwide_work, :for_kingdom_hall_construction_worldwide

  attr_accessor :other_receipt, :other_receipt_amount, :other_disbursement, :other_disbursement_amount



  
  def initialize args = {}
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    @receipts = []
    @expenditures = []
    @funds_reserved_for_special_purposes = []

    

  end




  def month
    @date.strftime("%B")
  end

  def year
    @date.year.to_s
  end




  def add_reciepts!(name, amount) 
    @receipts << PdfReportGenerator::DescriptionAndAmountPair.new(:name => name, :amount => amount)
  end

  def total_receipts
    #return 111111.11
    @receipts.compact.sum(&:amount).round(2)

  end

  def add_expenditure!(name, amount)
    @expenditures << PdfReportGenerator::DescriptionAndAmountPair.new(:name => name, :amount => amount)
  end

  def total_expenditures
    @expenditures.compact.sum(&:amount).round(2)
  end

  def surplus_deficit
    (total_receipts - total_expenditures).round(2)
  end

  def total_funds_at_end_of_month
    (funds_at_beginning_of_month.to_f.round(2) + surplus_deficit).round(2)
  end



  def add_funds_reserved_for_special_purpose!(name, amount)
    @funds_reserved_for_special_purposes << PdfReportGenerator::DescriptionAndAmountPair.new(:name => name, :amount => amount)
  end


  def total_funds_reserved_for_special_purposes
    @funds_reserved_for_special_purposes.compact.sum(&:amount).round(2)
  end


  def funds_available_to_cover_congregation_expenses
    (total_funds_at_end_of_month - total_funds_reserved_for_special_purposes).round(2)
  end


  def reconciliation_total_receipts
    (total_receipts + for_the_worldwide_work.to_f.round(2) + for_kingdom_hall_construction_worldwide.to_f.round(2) + other_receipt_amount.to_f.round(2)).round(2)
  end


  def reconciliation_total_disbursements
    (total_expenditures + for_the_worldwide_work.to_f.round(2) + for_kingdom_hall_construction_worldwide.to_f.round(2) + other_disbursement_amount.to_f.round(2)).round(2)
  end

  def reconciliation_total_funds_at_end_of_month
    (funds_at_beginning_of_month + reconciliation_total_receipts - reconciliation_total_disbursements).round(2)
  end






  def template_file
    #"#{Rails.root}/app/assets/pdf/MonthlyCongregationAccountsReport.pdf"
    File.join(Rails.root, 'app', 'assets', 'pdf', 'MonthlyCongregationAccountsReport.pdf')
  end



  def template_file_reconciliation
    #"#{Rails.root}/app/assets/pdf/Reconciliation.pdf"
    File.join(Rails.root, 'app', 'assets', 'pdf', 'Reconciliation.pdf')
  end



  def create_new_reconciliation_page!(pdf)
    pdf.start_new_page(:template => open(template_file_reconciliation))
  end







  def render_to_page!(pdf_object, first_page = false)

    ##### MONTHLY CONGREGATION ACCOUNTS REPORT PAGE, HERE
    unless first_page      
     create_new_page!(pdf_object)
    end

    ## CONGREGATION NAME
    text_box(pdf_object, 100, 97, self.congregation, :size => 12, :height => 20)

    ## DATE
    text_box(pdf_object, 400, 97, "#{self.month}, #{self.year}", :size => 12, :height => 20)    

    ## CONGREGATION FUNDS AT BEGINNING OF MONTH
    money_box(pdf_object, 439, 177, self.funds_at_beginning_of_month)  

    ## CONGREGATION RECIEPTS
    if @receipts
      @receipts.compact.each_with_index do |receipt, i|
        text_box(pdf_object, 42, 215.7 + (i * 16), receipt.name)
        money_box(pdf_object, 263, 216 + (i * 16), receipt.amount)

        
        
      end

      ## TOTAL RECEIPTS
      money_box(pdf_object, 346, 218 + (4 * 16), self.total_receipts)

    end    

    expenditures_disntance = 108
    ## CONGREGATION EXPENDITURES
    if @expenditures
      @expenditures.compact.each_with_index do |expenditure, i|
        text_box(pdf_object, 42, 215.7 + (i * 16) + expenditures_disntance, expenditure.name)
        money_box(pdf_object, 263, 216 + (i * 16) + expenditures_disntance, expenditure.amount)

        
        
      end

      ## TOTAL EXPENDITURES
      money_box(pdf_object, 346, 218 + (8 * 16) + expenditures_disntance, self.total_expenditures)

    end
   
    

    ## SURPLUS (DEFICIT)
    money_box(pdf_object, 439, 218 + (9 * 16) + expenditures_disntance, self.surplus_deficit)  

    ## CONGREGATION FUNDS AT END OF MONTH
    money_box(pdf_object, 439, 218 + (10 * 16) + expenditures_disntance, self.total_funds_at_end_of_month)  

    



    sp_purp_disntance = 312
    ## CONGREGATION FUNDS RESERVED FOR SPECIAL PURPOSES
    if @funds_reserved_for_special_purposes
      @funds_reserved_for_special_purposes.compact.each_with_index do |spf, i|
        text_box(pdf_object, 42, 215.7 + (i * 16.5) + sp_purp_disntance, spf.name)
        money_box(pdf_object, 263, 216 + (i * 16.5) + sp_purp_disntance, spf.amount)

        
        
      end

      ## TOTAL CONGREGATION FUNDS RESERVED FOR SPECIAL PURPOSES
      money_box(pdf_object, 346, 223 + (3 * 16.5) + sp_purp_disntance, self.total_funds_reserved_for_special_purposes)

    end


    

    ## FUNDS AVAILABLE TO COVER CONGREGATION EXPENSES
    money_box(pdf_object, 439, 223 + (5 * 16.5) + sp_purp_disntance, self.funds_available_to_cover_congregation_expenses)  


    #### RECONCILIATION PAGE, HERE
    create_new_reconciliation_page!(pdf_object)

    ## FORWARD - TOTAL FUNDS AT END OF MONTH
    money_box(pdf_object, 436, 42, self.funds_at_beginning_of_month)  

    ## CONGREGATION RECEIPTS - TOTAL   
    money_box(pdf_object, 262, 80, self.total_receipts)  

    ## FOR WORLDWIDE WORK
    money_box(pdf_object, 262, 112, self.for_the_worldwide_work)  

    ## FOR KINGDOM HALL CONSTRUCTION WORLDWIDE
    money_box(pdf_object, 262, 129, self.for_kingdom_hall_construction_worldwide)  

    ## OTHER RECEIPTS
    text_box(pdf_object, 44, 144, self.other_receipt)  

    ## OTHER RECEIPTS AMOUNT
    money_box(pdf_object, 262, 144, self.other_receipt_amount)  

    ## TOTAL RECEIPTS
    money_box(pdf_object, 348, 161, self.reconciliation_total_receipts)  

    ## CONGREGATION EXPENDITURES - TOTAL
    money_box(pdf_object, 262, 198, self.total_expenditures)    

    ## FOR WORLDWIDE WORK
    money_box(pdf_object, 262, 230, self.for_the_worldwide_work)  
 
    ## FOR KINGDOM HALL CONSTRUCTION WORLDWIDE
    money_box(pdf_object, 262, 246, self.for_kingdom_hall_construction_worldwide)  

    ## OTHER DISBURSEMENT
    text_box(pdf_object, 44, 261, self.other_disbursement)  

    ## OTHER DISBURSEMENT AMOUNT
    money_box(pdf_object, 262, 261, self.other_disbursement_amount) 

    ## TOTAL DISBURSEMENTS
    money_box(pdf_object, 348, 278, self.reconciliation_total_disbursements) 

    ## TOTAL FUNDS AT END OF MONTH
    money_box(pdf_object, 436, 322, self.reconciliation_total_funds_at_end_of_month)  
 
    ## ACCOUNT SERVANT NAME
    text_box(pdf_object, 348, 342, self.account_servant_name)


    ### MONTHLY CONGREGATION ACCOUNTS ANNOUNCEMENT

    ## DATE
    text_box(pdf_object, 111, 465, "#{self.month}, #{self.year}")    
   
    ## CONGREGATION RECEIVED TOTAL
    money_box(pdf_object, 363, 465, self.total_receipts) 

    ## CONGREGATION EXPENSES FOR THE MONTH TOTALED
    money_box(pdf_object, 195, 492, self.total_expenditures) 

    ## MONTH-END BALANCE
    money_box(pdf_object, 445, 492, self.total_funds_at_end_of_month) 

    ## FOR THE WORLDWIDE WORK
    money_box(pdf_object, 73, 543, self.for_the_worldwide_work)  

    ## FOR KINGDOM HALL CONSTRUCTION WORLDWIDE
    money_box(pdf_object, 307, 543, self.for_kingdom_hall_construction_worldwide)  



  

   

  end

  
  




  

  


end


end

end
