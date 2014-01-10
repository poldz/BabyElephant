reload!
system 'reset'


act_sheet_front = AccountSheetFrontPage.new
52.times {|i| act_sheet_front.set_sheet_detail! i+1, :transaction_detail => "the quick brown fox jumps over to the lazy dog #{i+1}"}






Prawn::Document.generate("background2.pdf") do |pdf|

  act_sheet_front.render_to_page!(pdf)



  #text "My report caption", :size => 18, :align => :right
  #move_down font.height * 2
  #text "Here is my text explaning this report. " * 20, :size => 12, :align => :left, :leading => 2
  #move_down font.height
  #text "I'm using a soft background. " * 40, :size => 12, :align => :left, :leading => 2
  


  #text_box "the quick brown fox jumps over to the lazy dog 2", :at => [10, cursor-77], :size => 8

  #pdf.start_new_page(:template => open(account_sheet_front_template))

  #(0..51).each do |line|
    #pdf.text_box "the quick brown fox jumps over to the lazy dog #{line}", :at => [10, pdf.cursor-(65 + (line * 11.3))], :size => 8



    #pdf.text_box "the quick brown fox jumps over to the lazy dog #{line}", :at => [10, pdf.cursor-(65 + (line * 11.3))], :size => 8, :align => :right




  #end

  #pdf.start_new_page(:template => open(account_sheet_back_template))
  #pdf.text "My report caption", :size => 18, :align => :right


end


