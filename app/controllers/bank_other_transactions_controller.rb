class BankOtherTransactionsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false


  # GET /bank_other_transactions
  # GET /bank_other_transactions.json
  def index
    @bank_other_transactions = @accounting_period.bank_other_transactions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_other_transactions }
    end
  end

  # GET /bank_other_transactions/1
  # GET /bank_other_transactions/1.json
  def show
    @bank_other_transaction = @accounting_period.bank_other_transactions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_other_transaction }
    end
  end

  # GET /bank_other_transactions/new
  # GET /bank_other_transactions/new.json
  def new
    @bank_other_transaction = @accounting_period.bank_other_transactions.build(params[:bank_other_transaction])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_other_transaction }
    end
  end

  # GET /bank_other_transactions/1/edit
  def edit
    @bank_other_transaction = @accounting_period.bank_other_transactions.find(params[:id])
  end

  # POST /bank_other_transactions
  # POST /bank_other_transactions.json
  def create
    @bank_other_transaction = @accounting_period.bank_other_transactions.build(bank_other_transaction_params)

    respond_to do |format|
      if @bank_other_transaction.save
        format.html { redirect_to [@account, @accounting_period, @bank_other_transaction], notice: 'Bank other transaction was successfully created.' }
        format.json { render json: @bank_other_transaction, status: :created, location: [@account, @accounting_period, @bank_other_transaction] }     
        format.js { @bank_other_transactions = @accounting_period.bank_other_transactions; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_other_transaction.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_other_transactions/1
  # PUT /bank_other_transactions/1.json
  def update
    @bank_other_transaction = @accounting_period.bank_other_transactions.find(params[:id])

    respond_to do |format|
      if @bank_other_transaction.update_attributes(bank_other_transaction_params)
        format.html { redirect_to [@account, @accounting_period, @bank_other_transaction], notice: 'Bank other transaction was successfully updated.' }
        format.json { render json: @bank_other_transaction, status: :ok }
        format.js { @bank_other_transactions = @accounting_period.bank_other_transactions; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_other_transaction.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_other_transactions/1
  # DELETE /bank_other_transactions/1.json
  def destroy
    @bank_other_transaction = @accounting_period.bank_other_transactions.find(params[:id])
    @bank_other_transaction.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_other_transactions_url(@account, @accounting_period) }
      format.json { head :no_content }   
      format.js { @bank_other_transactions = @accounting_period.bank_other_transactions; render 'update_list' }
    end
  end



  private

  def bank_other_transaction_params

    params.require(:bank_other_transaction).permit(
        :date,
        :bank_account,
        :description,
        :notes,
        :amount,
        :transaction_type
    )
  end

end
