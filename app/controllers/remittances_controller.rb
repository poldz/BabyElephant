class RemittancesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_bank_withdrawal_if_applicable


  layout false

  
  # GET /remittances
  # GET /remittances.json
  def index
    @remittances = @accounting_period.remittances

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @remittances }
    end
  end

  # GET /remittances/1
  # GET /remittances/1.json
  def show
    @remittance = @accounting_period.remittances.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @remittance }
    end
  end

  # GET /remittances/new
  # GET /remittances/new.json
  def new
    @remittance = @accounting_period.remittances.build(params[:remittance])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @remittance }
    end
  end

  # GET /remittances/1/edit
  def edit
    @remittance = @accounting_period.remittances.find(params[:id])
  end

  # POST /remittances
  # POST /remittances.json
  def create
    @remittance = @accounting_period.remittances.build(remittance_params)

    respond_to do |format|
      if @remittance.save
        
        arr_path = [@account, @accounting_period, @remittance]
        format.html { redirect_to arr_path, notice: 'Remittance was successfully created.' }
        format.json { render json: @remittance, status: :created, location: arr_path }
        format.js { @remittances = @accounting_period.remittances; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @remittance.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /remittances/1
  # PUT /remittances/1.json
  def update
    @remittance = @accounting_period.remittances.find(params[:id])

    respond_to do |format|
      if @remittance.update_attributes(remittance_params)
        arr_path = [@account, @accounting_period, @remittance]
        format.html { redirect_to arr_path, notice: 'Remittance was successfully updated.' }
        format.json { render json: @remittance, status: :ok }
        format.js { @remittances = @accounting_period.remittances; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @remittance.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /remittances/1
  # DELETE /remittances/1.json
  def destroy
    @remittance = @accounting_period.remittances.find(params[:id])
    @remittance.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_remittances_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @remittances = @accounting_period.remittances; render 'update_list' }
    end
  end



  private

  def remittance_params

    params.require(:remittance).permit(
        :bank_withdrawal_id,
        :date,
        :source_of_fund,
        :remittance_type,
        :description,
        :amount,
        :notes
    )
  end


end
