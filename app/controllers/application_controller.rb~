class ApplicationController < ActionController::Base
  protect_from_forgery




  protected

  def set_account
    @account = current_user.accounts.find(params[:account_id])
  end

  def set_accounting_period
    set_account unless @account
    @accounting_period = @account.accounting_periods.find(params[:accounting_period_id])
  end

  def set_bank_withdrawal_if_applicable
    set_accounting_period unless @accounting_period
    if params[:bank_withdrawal_id]
      @bank_withdrawal = @accounting_period.bank_withdrawals.find(params[:bank_withdrawal_id])
    end

  end
end
