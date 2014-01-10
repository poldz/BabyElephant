class BankFeesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period


  layout false


  # GET /bank_fees
  # GET /bank_fees.json
  def index
    @bank_fees = @accounting_period.bank_fees

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_fees }
    end
  end

  # GET /bank_fees/1
  # GET /bank_fees/1.json
  def show
    @bank_fee = @accounting_period.bank_fees.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_fee }
    end
  end

  # GET /bank_fees/new
  # GET /bank_fees/new.json
  def new
    @bank_fee = @accounting_period.bank_fees.build(params[:bank_fee])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_fee }
    end
  end

  # GET /bank_fees/1/edit
  def edit
    @bank_fee = @accounting_period.bank_fees.find(params[:id])
  end

  # POST /bank_fees
  # POST /bank_fees.json
  def create
    @bank_fee = @accounting_period.bank_fees.build(params[:bank_fee])

    respond_to do |format|
      if @bank_fee.save
        format.html { redirect_to [@account, @accounting_period, @bank_fee], notice: 'Bank fee was successfully created.' }
        format.json { render json: @bank_fee, status: :created, location: [@account, @accounting_period, @bank_fee] }     
        format.js { @bank_fees = @accounting_period.bank_fees; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_fee.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_fees/1
  # PUT /bank_fees/1.json
  def update
    @bank_fee = @accounting_period.bank_fees.find(params[:id])

    respond_to do |format|
      if @bank_fee.update_attributes(params[:bank_fee])
        format.html { redirect_to [@account, @accounting_period, @bank_fee], notice: 'Bank fee was successfully updated.' }
        format.json { render json: @bank_fee, status: :ok }
        format.js { @bank_fees = @accounting_period.bank_fees; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_fee.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_fees/1
  # DELETE /bank_fees/1.json
  def destroy
    @bank_fee = @accounting_period.bank_fees.find(params[:id])
    @bank_fee.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_fees_url(@account, @accounting_period) }
      format.json { head :no_content }     
      format.js { @bank_fees = @accounting_period.bank_fees; render 'update_list' }
    end
  end
end
