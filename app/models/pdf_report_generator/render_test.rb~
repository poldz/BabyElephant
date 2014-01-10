module PdfReportGenerator

class RenderTest

  


  def self.run
 
    act_sheet = generate_account_sheet
    monthly_report = generate_monthly_congregation_accounts_report
    remittance_form = generate_remittance_form
    

    Prawn::Document.generate("background2.pdf", :template => act_sheet.template_file) do |pdf|      
      act_sheet.render_to_page!(pdf, true)
      monthly_report.render_to_page!(pdf, false)
      remittance_form.render_to_page!(pdf, false)
    end



  end

  def self.generate_remittance_form
    rem = PdfReportGenerator::RemittanceForm::RemittanceForm.new
  

    rem.is_congregation = true
    rem.is_circuit = true
    rem.is_kh_operating_committee = true


    rem.name_of_congregation = "Jones AAAAAAA"
    rem.congregation_number = "1111111"
    rem.date = DateTime.now
    rem.city_or_town = "Cebu City"
    rem.province = "Cebu"
  
    rem.worldwide_work = rand_amount
    rem.kingdom_hall_construction_worldwide = rand_amount
    rem.branch_owned_kingdom_hall = rand_amount
    rem.kingdom_hall_loans_repayment = rand_amount
    rem.funds_on_deposit = rand_amount
    rem.kingdom_hall_assistance_arrangement = rand_amount
    rem.relief_fund = rand_amount
    rem.circuit_fund = rand_amount
    rem.assembly_hall_fund = rand_amount
    rem.others_1 = "the quick brown fox jumps over to the lazy dog 111"
    rem.others_1_amount = rand_amount
    rem.others_2 = "the quick brown fox jumps over to the lazy dog 222"
    rem.others_2_amount = rand_amount

    rem.account_servant_name = "Leopolod Lee Agdeppa III"
    rem.secritary_name = "John Austria"

    return rem

  end


  def self.generate_monthly_congregation_accounts_report
    rep = PdfReportGenerator::MonthlyCongregationAccountsReport::MonthlyCongregationAccountsReport.new
    rep.date = (DateTime.now).beginning_of_month
    rep.congregation = "Jones Test Congregation Value"
    rep.account_servant_name = "Leopoldo Lee Agdeppa III"
    rep.funds_at_beginning_of_month = 10012.34

    rep.for_the_worldwide_work = 12345.67
    rep.for_kingdom_hall_construction_worldwide = 34567.89

    rep.other_receipt = "the quick bronwn fox jumps over 111"
    rep.other_receipt_amount = 11111.11

    rep.other_disbursement = "the quick brown fox jumps over 222"
    rep.other_disbursement_amount = 2222.22
    

    # Add Receipts
    rep.add_reciepts! "From Congregation Box", 20056.11
    rep.add_reciepts! "Bank Interest", 30056.22
    rep.add_reciepts! "test others 111", 40056.33
    rep.add_reciepts! "test others 222", 50056.44


    # Add Expenditures
    rep.add_expenditure! "Test Expenditure 11111", 60011.11
    rep.add_expenditure! "Test Expenditure 222", 60022.22
    rep.add_expenditure! "Test Expenditure 33333", 60033.33
    rep.add_expenditure! "Test Expenditure 44444", 60044.44
    rep.add_expenditure! "Test Expenditure 555", 60055.55
    rep.add_expenditure! "Test Expenditure 66666", 60066.66
    rep.add_expenditure! "Test Expenditure 77777", 60077.77
    rep.add_expenditure! "Test Expenditure 88888", 60088.88


    # Add Congregation Funds Reserved For Special Purpose
    rep.add_funds_reserved_for_special_purpose! "test Funds Reserved for Sp Purp. 1", 11111.11
    rep.add_funds_reserved_for_special_purpose! "test Funds Reserved for Sp Purp. 2", 22222.11
    rep.add_funds_reserved_for_special_purpose! "test Funds Reserved for Sp Purp. 3", 33333.11
 


    return rep


  end
  





  def self.generate_account_sheet

     
     act_sheet = PdfReportGenerator::AccountSheet::AccountSheet.new

     act_sheet.congregation_or_circuit = "Jones"
     act_sheet.city = 'Cebu City'
     act_sheet.province_or_state = "Cebu"
     act_sheet.date = (DateTime.now).beginning_of_month
     
     act_sheet.checking_account_name = "Checking Test Value"
     act_sheet.other_account_name = "Other Test Value"
     
     act_sheet.receipts_balance_forward = 1000.12

     act_sheet.checking_balance_forward = 2000.34

     act_sheet.other_balance_forward = 3000.56

     
     act_sheet.add_obligations_at_eom_current!("KHOC 11111", 2001.11)
     act_sheet.add_obligations_at_eom_current!("KHOC 222222", 2002.22)
     act_sheet.add_obligations_at_eom_current!("KHOC 33333", 2003.33)
     act_sheet.add_obligations_at_eom_current!("KHOC  44444", 2004.44)
     act_sheet.add_obligations_at_eom_current!("KHOC 555", 2005.55)
     act_sheet.add_obligations_at_eom_current!("KHOC66666666", 2006.66)
     act_sheet.add_obligations_at_eom_current!("KHOC 77777", 2007.77)
     act_sheet.add_obligations_at_eom_current!("KHOC 888888", 2008.88)
     act_sheet.add_obligations_at_eom_current!("KHOC 999999", 2009.99)
     act_sheet.add_obligations_at_eom_current!("KHOC 1010", 2010)

     

     act_sheet.add_obligations_at_eom_long_term!("Loan 11111", 3001.11)
     act_sheet.add_obligations_at_eom_long_term!("Loan 222222", 3002.22)
     act_sheet.add_obligations_at_eom_long_term!("Loan 33333", 3003.33)
     act_sheet.add_obligations_at_eom_long_term!("Loan  44444", 3004.44)
     act_sheet.add_obligations_at_eom_long_term!("Loan 555", 3005.55)
     act_sheet.add_obligations_at_eom_long_term!("Loan66666666", 3006.66)
     act_sheet.add_obligations_at_eom_long_term!("Loan 77777", 3007.77)
   
     
     


     (1..100).to_a.sample.times do|i| 

       str_description = ["the quick brown fox jumps over to the lazy dog test d e s c r i p t i o n #{i+1}", "the quick brown fox jumps over to the #{i+1}"]
       str_note = ["this is just a sample note", "note only note only note only"]
  


       trans = case (1..6).to_a.sample
       when 1 # recepts in
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :receipt_in => rand_amount, :tc => rand_tc)
       when 2 # recepts out
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :receipt_out => rand_amount, :tc => rand_tc)
       when 3 # checking in
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :checking_in => rand_amount, :tc => rand_tc)
       when 4 # checking out
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :checking_out => rand_amount, :tc => rand_tc)
       when 5 # other in
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :other_in => rand_amount, :tc => rand_tc)
       when 6 # other out
         PdfReportGenerator::AccountSheet::AccountSheetTransaction.new(:date => rand_date,  :transaction_description => str_description.sample, :other_out => rand_amount, :tc => rand_tc)
       end

       (0..5).to_a.sample.times do 
         trans.add_note! str_note.sample, rand_amount
       end

       act_sheet.add_transaction! trans


    end


   return act_sheet


  end





  def self.rand_date from = Time.now.beginning_of_month, to = (Time.now.end_of_month + 2.days)
    t = Time.at(from + rand * (to.to_f - from.to_f))
    DateTime.new(t.year,t.month,t.day)  
  end

  def self.rand_amount
    #return 12345678.21
    #(rand * (9999999.99-0.1) + 0.1).round(2)
    (rand * (99999.99-0.1) + 0.1).round(2)
  end

  def self.rand_tc
    ['W', 'K', 'C', 'I', 'T'].sample
  end




end


end



