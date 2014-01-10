class BankDepositsController < ApplicationController


  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false

  # GET /bank_deposits
  # GET /bank_deposits.json
  def index
    @bank_deposits = @accounting_period.bank_deposits.order(:date)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_deposits }
    end
  end

  # GET /bank_deposits/1
  # GET /bank_deposits/1.json
  def show
    @bank_deposit = @accounting_period.bank_deposits.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_deposit }
    end
  end

  # GET /bank_deposits/new
  # GET /bank_deposits/new.json
  def new
    @bank_deposit = @accounting_period.bank_deposits.build(params[:bank_deposit])
    @bank_deposit.date = @accounting_period.date unless @bank_deposit.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_deposit }
    end
  end

  # GET /bank_deposits/1/edit
  def edit
    @bank_deposit = @accounting_period.bank_deposits.find(params[:id])
  end

  # POST /bank_deposits
  # POST /bank_deposits.json
  def create
    @bank_deposit = @accounting_period.bank_deposits.build(params[:bank_deposit])

    respond_to do |format|
      if @bank_deposit.save
        format.html { redirect_to [@account, @accounting_period, @bank_deposit], notice: 'Bank deposit was successfully created.' }
        format.json { render json: @bank_deposit, status: :created, location: [@account, @accounting_period, @bank_deposit] }        
        format.js { @bank_deposits = @accounting_period.bank_deposits; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_deposit.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_deposits/1
  # PUT /bank_deposits/1.json
  def update
    @bank_deposit = @accounting_period.bank_deposits.find(params[:id])

    respond_to do |format|
      if @bank_deposit.update_attributes(params[:bank_deposit])
        format.html { redirect_to [@account, @accounting_period, @bank_deposit], notice: 'Bank deposit was successfully updated.' }
        format.json { render json: @bank_deposit, status: :ok }
        format.js { @bank_deposits = @accounting_period.bank_deposits; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_deposit.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_deposits/1
  # DELETE /bank_deposits/1.json
  def destroy
    @bank_deposit = @accounting_period.bank_deposits.find(params[:id])
    @bank_deposit.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_deposits_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @bank_deposits = @accounting_period.bank_deposits; render 'update_list' }
    end
  end
end
