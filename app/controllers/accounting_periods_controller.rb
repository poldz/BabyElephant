class AccountingPeriodsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_account

  def generate_report
    @accounting_period = @account.accounting_periods.find(params[:id])
    rep = @accounting_period.generate_report!
    send_file rep
  end


  def summary
    @accounting_period = @account.accounting_periods.find(params[:id])

    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @accounting_period }
    end

  end



  def forecast
    @accounting_period = @account.accounting_periods.find(params[:id])

    respond_to do |format|
      format.html { render layout: false }
      format.json { render json: @accounting_period }
    end

  end


  # GET /accounting_periods
  # GET /accounting_periods.json
  def index
    @accounting_periods = @account.accounting_periods

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounting_periods }
    end
  end

  # GET /accounting_periods/1
  # GET /accounting_periods/1.json
  def show
    @accounting_period = @account.accounting_periods.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @accounting_period }
    end
  end

  # GET /accounting_periods/new
  # GET /accounting_periods/new.json
  def new
    @accounting_period = @account.accounting_periods.build(params[:accounting_period])
    

    last_act_period = @account.accounting_periods.order("date desc").limit(1).last

    if last_act_period
      @accounting_period.date = (last_act_period.date + 1.month) unless @accounting_period.date
      @accounting_period.receipts_balance_forward = last_act_period.current_total_receipts_undeposited if @accounting_period.receipts_balance_forward.nil? or @accounting_period.receipts_balance_forward <= 0.00
      @accounting_period.checking_balance_forward = last_act_period.current_total_checking_balance if @accounting_period.checking_balance_forward.nil? or @accounting_period.checking_balance_forward <= 0.00
      @accounting_period.other_account_balance_forward = last_act_period.current_total_other_account_balance if @accounting_period.other_account_balance_forward.nil? or @accounting_period.other_account_balance_forward <= 0.00
      @accounting_period.total_funds_at_bom = last_act_period.current_total_funds if @accounting_period.total_funds_at_bom.nil? or @accounting_period.total_funds_at_bom <= 0.00
       

    else
      @accounting_period.date = (Time.now).beginning_of_month unless @accounting_period.date

    end


    @accounting_period.checking_account_rename = @account.checking_account_rename unless @accounting_period.checking_account_rename
    @accounting_period.other_account_name = @account.other_account_name unless @accounting_period.other_account_name
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @accounting_period }
    end
  end

  # GET /accounting_periods/1/edit
  def edit
    @accounting_period = @account.accounting_periods.find(params[:id])
  end

  # POST /accounting_periods
  # POST /accounting_periods.json
  def create
    @accounting_period = @account.accounting_periods.build(params[:accounting_period])
    @accounting_period.created_by_id = current_user.id

    respond_to do |format|
      if @accounting_period.save
        format.html { redirect_to [@account, @accounting_period], notice: 'Accounting period was successfully created.' }
        format.json { render json: @accounting_period, status: :created, location: [@account, @accounting_period] }
      else
        format.html { render action: "new" }
        format.json { render json: @accounting_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounting_periods/1
  # PUT /accounting_periods/1.json
  def update
    @accounting_period = @account.accounting_periods.find(params[:id])

    respond_to do |format|
      if @accounting_period.update_attributes(params[:accounting_period])
        format.html { redirect_to [@account, @accounting_period], notice: 'Accounting period was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @accounting_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounting_periods/1
  # DELETE /accounting_periods/1.json
  def destroy
    @accounting_period = @account.accounting_periods.find(params[:id])
    @accounting_period.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_periods_url(@account) }
      format.json { head :no_content }
    end
  end


end
