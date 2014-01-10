class ReceiptsController < ApplicationController


  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false

  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = @accounting_period.receipts.order("date")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @receipts }
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @receipt = @accounting_period.receipts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/new
  # GET /receipts/new.json
  def new
    @receipt = @accounting_period.receipts.build(params[:receipt])
    @receipt.date = @accounting_period.date unless @receipt.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @receipt }
    end
  end

  # GET /receipts/1/edit
  def edit
    @receipt = @accounting_period.receipts.find(params[:id])
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = @accounting_period.receipts.build(params[:receipt])

    respond_to do |format|
      if @receipt.save
        format.html { redirect_to [@receipt.accounting_period.account, @receipt.accounting_period, @receipt], notice: 'Receipt was successfully created.' }
        format.json { render json: @receipt, status: :created, location: [@receipt.accounting_period.account, @receipt.accounting_period, @receipt] }
        format.js { @receipts = @accounting_period.receipts; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /receipts/1
  # PUT /receipts/1.json
  def update
    @receipt = @accounting_period.receipts.find(params[:id])

    respond_to do |format|
      if @receipt.update_attributes(params[:receipt])
        format.html { redirect_to [@receipt.accounting_period.account, @receipt.accounting_period, @receipt], notice: 'Receipt was successfully updated.' }
        format.json { render json: @receipt, status: :ok }
        format.js { @receipts = @accounting_period.receipts; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt = @accounting_period.receipts.find(params[:id])
    @receipt.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_receipts_url(@receipt.accounting_period.account, @receipt.accounting_period) }
      format.json { head :no_content }
      format.js { @receipts = @accounting_period.receipts; render 'update_list' }
    end
  end
end
