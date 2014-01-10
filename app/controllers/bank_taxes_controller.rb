class BankTaxesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false


  # GET /bank_taxes
  # GET /bank_taxes.json
  def index
    @bank_taxes = @accounting_period.bank_taxes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_taxes }
    end
  end

  # GET /bank_taxes/1
  # GET /bank_taxes/1.json
  def show
    @bank_tax = @accounting_period.bank_taxes.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_tax }
    end
  end

  # GET /bank_taxes/new
  # GET /bank_taxes/new.json
  def new
    @bank_tax = @accounting_period.bank_taxes.build(params[:bank_tax])
    @bank_tax.date = @accounting_period.date.end_of_month unless @bank_tax.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_tax }
    end
  end

  # GET /bank_taxes/1/edit
  def edit
    @bank_tax = @accounting_period.bank_taxes.find(params[:id])
  end

  # POST /bank_taxes
  # POST /bank_taxes.json
  def create
    @bank_tax = @accounting_period.bank_taxes.build(params[:bank_tax])

    respond_to do |format|
      if @bank_tax.save
        format.html { redirect_to account_accounting_period_bank_taxis_path(@account, @accounting_period, @bank_tax), notice: 'Bank tax was successfully created.' }
        format.json { render json: @bank_tax, status: :created, location: account_accounting_period_bank_taxis_path(@account, @accounting_period, @bank_tax) }
        format.js { @bank_taxes = @accounting_period.bank_taxes; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_tax.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_taxes/1
  # PUT /bank_taxes/1.json
  def update
    @bank_tax = @accounting_period.bank_taxes.find(params[:id])

    respond_to do |format|
      if @bank_tax.update_attributes(params[:bank_tax])
        format.html { redirect_to account_accounting_period_bank_taxis_path(@account, @accounting_period, @bank_tax), notice: 'Bank tax was successfully updated.' }
        format.json { render json: @bank_tax, status: :ok }
        format.js { @bank_taxes = @accounting_period.bank_taxes; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_tax.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_taxes/1
  # DELETE /bank_taxes/1.json
  def destroy
    @bank_tax = @accounting_period.bank_taxes.find(params[:id])
    @bank_tax.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_taxes_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @bank_taxes = @accounting_period.bank_taxes; render 'update_list' }
    end
  end
end
