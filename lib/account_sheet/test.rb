reload!

a = AccountSheetFrontPage.new :congregation_or_circuit => 'Jones', :city => 'Cebu City', :province_or_state => 'Cebu', :month => 2, :year => 2013

#a.add_detail(date => Date.new, :transaction_description => 'Test only', :tc => 'C', :receipt_in => 100.25, :receipt_out, :checking_in, :checking_out, :other_in, :other_out)

a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :receipt_in => 100.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :receipt_in => 12.75)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :receipt_in => 12.75)


a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :receipt_out => 20.00)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :receipt_out => 95.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :receipt_out => 30.25)



a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :checking_in => 100.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :checking_in => 12.75)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :checking_in => 12.75)


a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :checking_out => 20.00)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :checking_out => 95.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :checking_out => 30.25)




a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :other_in => 100.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :other_in => 12.75)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :other_in => 12.75)


a.add_detail(:date => Date.new, :transaction_description => 'Test only 1', :tc => 'C', :other_out => 20.00)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 2', :tc => 'C', :other_out => 95.25)
a.add_detail(:date => Date.new, :transaction_description => 'Test only 3', :tc => 'C', :other_out => 30.25)



puts ">>>> #{a.total_reciepts_in}"
puts ">>>> #{a.total_reciepts_out}"



puts ">>>> #{a.total_checking_in}"
puts ">>>> #{a.total_checking_out}"



puts ">>>> #{a.total_other_in}"
puts ">>>> #{a.total_other_out}"






