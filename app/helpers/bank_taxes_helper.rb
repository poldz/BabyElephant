module BankTaxesHelper
  def account_accounting_period_bank_tax_path(account, accounting_period, bank_tax, *args)
   account_id = nil
   if account.is_a? Numeric
     account_id = account 
   else
     account_id = account.id
   end

   accounting_period_id = nil
   if accounting_period.is_a? Numeric
     accounting_period_id = accounting_period 
   else
     accounting_period_id = accounting_period.id
   end

   bank_tax_id = nil
   if bank_tax.is_a? Numeric
     bank_tax_id = bank_tax 
   else
     bank_tax_id = bank_tax.id
   end

   "/accounts/#{account_id}/accounting_periods/#{accounting_period_id}/bank_taxes/#{bank_tax.id}"
  end
end
