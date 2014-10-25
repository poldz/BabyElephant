class ExpensesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_bank_withdrawal_if_applicable

  layout false


  
  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = @accounting_period.expenses

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = @accounting_period.expenses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = @accounting_period.expenses.build(params[:expense])
    @expense.date = @accounting_period.date unless @expense.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = @accounting_period.expenses.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = @accounting_period.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        arr_path = [@account, @accounting_period, @expense]

        format.html { redirect_to arr_path, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: arr_path }
        format.js { @expenses = @accounting_period.expenses; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = @accounting_period.expenses.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(expense_params)
        
        arr_path = [@account, @accounting_period, @expense]
        format.html { redirect_to arr_path, notice: 'Expense was successfully updated.' }
        format.json { render json: @expense, status: :ok }
        format.js { @expenses = @accounting_period.expenses; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = @accounting_period.expenses.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_expenses_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @expenses = @accounting_period.expenses; render 'update_list' }
    end
  end


  private

  def expense_params

    params.require(:expense).permit(
        :bank_withdrawal_id,
        :date,
        :source_of_fund,
        :description,
        :amount,
        :notes
    )
  end

end
