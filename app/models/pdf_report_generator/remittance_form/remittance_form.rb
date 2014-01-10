

module PdfReportGenerator

module RemittanceForm

class RemittanceForm < PdfReportGenerator::PDFRenderable

  attr_accessor :is_congregation, :is_circuit, :is_kh_operating_committee

  attr_accessor :date, :name_of_congregation, :congregation_number, :city_or_town, :province
  attr_accessor :worldwide_work, :kingdom_hall_construction_worldwide, :branch_owned_kingdom_hall, 
      :kingdom_hall_loans_repayment, :funds_on_deposit, :kingdom_hall_assistance_arrangement,
      :relief_fund, :circuit_fund, :assembly_hall_fund, :others_1, :others_1_amount, :others_2, :others_2_amount

  attr_accessor :account_servant_name, :secritary_name



  
  def initialize args = {}
    

    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end

    

  end

  def total_donations_and_payment
    total = 0.00
    total += worldwide_work.to_f.round(2)
    total += kingdom_hall_construction_worldwide.to_f.round(2)
    total += branch_owned_kingdom_hall.to_f.round(2)
    total += kingdom_hall_loans_repayment.to_f.round(2)
    total += funds_on_deposit.to_f.round(2)    
    total += kingdom_hall_assistance_arrangement.to_f.round(2)
    total += relief_fund.to_f.round(2)
    total += circuit_fund.to_f.round(2)
    total += assembly_hall_fund.to_f.round(2)
    total += others_1_amount.to_f.round(2)
    total += others_2_amount.to_f.round(2)
   
   

    return total.round(2)

  end




  def month
    @date.strftime("%B")
  end

  def year
    @date.year.to_s
  end







  def template_file
    #"#{Rails.root}/app/assets/pdf/RemittanceForm.pdf"
    File.join(Rails.root, 'app', 'assets', 'pdf', 'RemittanceForm.pdf')
  end








  def render_to_page!(pdf_object, first_page = false)

    unless first_page      
     create_new_page!(pdf_object)
    end

    
    if self.is_congregation == true
      text_box(pdf_object, 65, 169, "X")
    end

    if self.is_circuit == true
      text_box(pdf_object, 225, 169, "X")
    end

    if self.is_kh_operating_committee == true
      text_box(pdf_object, 349, 169, "X")
    end

    ## NAME OF CONGREGATION
    text_box(pdf_object, 70, 184, self.name_of_congregation)
  
    ## CONGREGATION NUMBER
    text_box(pdf_object, 240, 184, self.congregation_number)

    ## DATE
    text_box(pdf_object, 410, 184, self.date.strftime("%B/%d/%Y")) 

    ## CITY OR TOWN
    text_box(pdf_object, 70, 208, self.city_or_town)

    ## PROVINCE
    text_box(pdf_object, 350, 208, self.province)


    distance = 14
    money_box(pdf_object, 428, 248, self.worldwide_work)
    money_box(pdf_object, 428, 248 + (distance * 1), self.kingdom_hall_construction_worldwide)
    money_box(pdf_object, 428, 248 + (distance * 2), self.branch_owned_kingdom_hall)
    money_box(pdf_object, 428, 248 + (distance * 3), self.kingdom_hall_loans_repayment)
    money_box(pdf_object, 428, 248 + (distance * 4), self.funds_on_deposit)
    money_box(pdf_object, 428, 248 + (distance * 5), self.kingdom_hall_assistance_arrangement)
    money_box(pdf_object, 428, 248 + (distance * 6), self.relief_fund)
    money_box(pdf_object, 428, 248 + (distance * 7), self.circuit_fund)
    money_box(pdf_object, 428, 248 + (distance * 8), self.assembly_hall_fund)

    text_box(pdf_object, 120, 248 + (distance * 9), self.others_1)
    money_box(pdf_object, 428, 248 + (distance * 9), self.others_1_amount)

    money_box(pdf_object, 428, 248 + (distance * 10), self.others_2_amount)    
    text_box(pdf_object, 120, 248 + (distance * 10), self.others_2)

    money_box(pdf_object, 428, 248 + (distance * 11.3), self.total_donations_and_payment)


   
    text_box(pdf_object, 150, 495, self.account_servant_name)

    text_box(pdf_object, 390, 495, self.secritary_name)
 

    
  

   

  end

  
  




  

  


end


end

end
