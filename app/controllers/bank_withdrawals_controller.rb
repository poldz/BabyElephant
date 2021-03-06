class BankWithdrawalsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false

  # GET /bank_withdrawals
  # GET /bank_withdrawals.json
  def index
    @bank_withdrawals = @accounting_period.bank_withdrawals

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_withdrawals }
    end
  end

  # GET /bank_withdrawals/1
  # GET /bank_withdrawals/1.json
  def show
    @bank_withdrawal = @accounting_period.bank_withdrawals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_withdrawal }
    end
  end

  # GET /bank_withdrawals/new
  # GET /bank_withdrawals/new.json
  def new
    @bank_withdrawal = @accounting_period.bank_withdrawals.build(params[:bank_withdrawal])
    @bank_withdrawal.date = @accounting_period.date.end_of_month unless @bank_withdrawal.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_withdrawal }
    end
  end

  # GET /bank_withdrawals/1/edit
  def edit
    @bank_withdrawal = @accounting_period.bank_withdrawals.find(params[:id])
  end

  # POST /bank_withdrawals
  # POST /bank_withdrawals.json
  def create
    @bank_withdrawal = @accounting_period.bank_withdrawals.build(bank_withdrawal_params)

    respond_to do |format|
      if @bank_withdrawal.save
        format.html { redirect_to [@account, @accounting_period, @bank_withdrawal], notice: 'Bank withdrawal was successfully created.' }
        format.json { render json: @bank_withdrawal, status: :created, location: [@account, @accounting_period, @bank_withdrawal] }
        format.js { @bank_withdrawals = @accounting_period.bank_withdrawals; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_withdrawal.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_withdrawals/1
  # PUT /bank_withdrawals/1.json
  def update
    @bank_withdrawal = @accounting_period.bank_withdrawals.find(params[:id])

    respond_to do |format|
      if @bank_withdrawal.update_attributes(bank_withdrawal_params)
        format.html { redirect_to [@account, @accounting_period, @bank_withdrawal], notice: 'Bank withdrawal was successfully updated.' }
        format.json { render json: @bank_withdrawal, status: :ok }
        format.js { @bank_withdrawals = @accounting_period.bank_withdrawals; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_withdrawal.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_withdrawals/1
  # DELETE /bank_withdrawals/1.json
  def destroy
    @bank_withdrawal = @accounting_period.bank_withdrawals.find(params[:id])
    @bank_withdrawal.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_withdrawals_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @bank_withdrawals = @accounting_period.bank_withdrawals; render 'update_list' }
    end
  end


  private

  def bank_withdrawal_params

    params.require(:bank_withdrawal).permit(
        :date,
        :bank_account,
        :amount,
        :note
    )
  end
end
