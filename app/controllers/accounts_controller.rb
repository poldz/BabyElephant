class AccountsController < ApplicationController

  before_filter :authenticate_user!


  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = current_user.accounts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = current_user.accounts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = current_user.accounts.build(params[:account])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = current_user.accounts.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = current_user.accounts.build(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = current_user.accounts.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :no_content }
    end
  end



  def account_params
    params.require(:account).permit(
        :account_name,
        :account_type,
        :account_number,
        :city_or_town,
        :province_or_state,
        :account_servant_name,
        :secritary_name,
        :checking_account_rename,
        :other_account_name,
        :other_account_name,
        :society_bank_account_name,
        :society_bank_account_number,
        :checking_account_name_on_bank_account,
        :checking_account_bank_account_number,
        :other_account_name_on_bank_account,
        :other_account_bank_account_number,
        :tmp_1,
        :tmp_2
    )
  end
end
