class BankPenaltiesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false


  # GET /bank_penalties
  # GET /bank_penalties.json
  def index
    @bank_penalties = @accounting_period.bank_penalties

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_penalties }
    end
  end

  # GET /bank_penalties/1
  # GET /bank_penalties/1.json
  def show
    @bank_penalty = @accounting_period.bank_penalties.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_penalty }
    end
  end

  # GET /bank_penalties/new
  # GET /bank_penalties/new.json
  def new
    @bank_penalty = @accounting_period.bank_penalties.build(params[:bank_penalty])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_penalty }
    end
  end

  # GET /bank_penalties/1/edit
  def edit
    @bank_penalty = @accounting_period.bank_penalties.find(params[:id])
  end

  # POST /bank_penalties
  # POST /bank_penalties.json
  def create
    @bank_penalty = @accounting_period.bank_penalties.build(params[:bank_penalty])

    respond_to do |format|
      if @bank_penalty.save
        format.html { redirect_to [@account, @accounting_period, @bank_penalty], notice: 'Bank penalty was successfully created.' }
        format.json { render json: @bank_penalty, status: :created, location: [@account, @accounting_period, @bank_penalty] }   
        format.js { @bank_penalties = @accounting_period.bank_penalties; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_penalty.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_penalties/1
  # PUT /bank_penalties/1.json
  def update
    @bank_penalty = @accounting_period.bank_penalties.find(params[:id])

    respond_to do |format|
      if @bank_penalty.update_attributes(params[:bank_penalty])
        format.html { redirect_to [@account, @accounting_period, @bank_penalty], notice: 'Bank penalty was successfully updated.' }
        format.json { render json: @bank_penalty, status: :ok }
        format.js { @bank_penalties = @accounting_period.bank_penalties; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_penalty.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_penalties/1
  # DELETE /bank_penalties/1.json
  def destroy
    @bank_penalty = @accounting_period.bank_penalties.find(params[:id])
    @bank_penalty.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_penalties_url(@account, @accounting_period) }
      format.json { head :no_content }
      format.js { @bank_penalties = @accounting_period.bank_penalties; render 'update_list' }
    end
  end
end
