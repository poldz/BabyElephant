class BankInterestsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_accounting_period

  layout false

  # GET /bank_interests
  # GET /bank_interests.json
  def index
    @bank_interests = @accounting_period.bank_interests

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bank_interests }
    end
  end

  # GET /bank_interests/1
  # GET /bank_interests/1.json
  def show
    @bank_interest = @accounting_period.bank_interests.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bank_interest }
    end
  end

  # GET /bank_interests/new
  # GET /bank_interests/new.json
  def new
    @bank_interest = @accounting_period.bank_interests.build(params[:bank_interest])
    @bank_interest.date = @accounting_period.date.end_of_month unless @bank_interest.date

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bank_interest }
    end
  end

  # GET /bank_interests/1/edit
  def edit
    @bank_interest = @accounting_period.bank_interests.find(params[:id])
  end

  # POST /bank_interests
  # POST /bank_interests.json
  def create
    @bank_interest = @accounting_period.bank_interests.build(bank_interest_params)

    respond_to do |format|
      if @bank_interest.save
        format.html { redirect_to [@account, @accounting_period, @bank_interest], notice: 'Bank interest was successfully created.' }
        format.json { render json: @bank_interest, status: :created, location: [@account, @accounting_period, @bank_interest] }     
        format.js { @bank_interests = @accounting_period.bank_interests; render 'update_list' }
      else
        format.html { render action: "new" }
        format.json { render json: @bank_interest.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PUT /bank_interests/1
  # PUT /bank_interests/1.json
  def update
    @bank_interest = @accounting_period.bank_interests.find(params[:id])

    respond_to do |format|
      if @bank_interest.update_attributes(bank_interest_params)
        format.html { redirect_to [@account, @accounting_period, @bank_interest], notice: 'Bank interest was successfully updated.' }
        format.json { render json: @bank_interest, status: :ok }
        format.js { @bank_interests = @accounting_period.bank_interests; render 'update_list' }
      else
        format.html { render action: "edit" }
        format.json { render json: @bank_interest.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # DELETE /bank_interests/1
  # DELETE /bank_interests/1.json
  def destroy
    @bank_interest = @accounting_period.bank_interests.find(params[:id])
    @bank_interest.destroy

    respond_to do |format|
      format.html { redirect_to account_accounting_period_bank_interests_url(@account, @accounting_period) }
      format.json { head :no_content }     
      format.js { @bank_interests = @accounting_period.bank_interests; render 'update_list' }
    end
  end


  private

  def bank_interest_params

    params.require(:bank_interest).permit(
        :date,
        :bank_account,
        :amount
    )
  end
end
