require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: { account_name: @account.account_name, account_number: @account.account_number, account_servant_name: @account.account_servant_name, account_type: @account.account_type, checking_account_rename: @account.checking_account_rename, city_or_town: @account.city_or_town, other_account_name: @account.other_account_name, province_or_state: @account.province_or_state, secritary_name: @account.secritary_name }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, id: @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account
    assert_response :success
  end

  test "should update account" do
    put :update, id: @account, account: { account_name: @account.account_name, account_number: @account.account_number, account_servant_name: @account.account_servant_name, account_type: @account.account_type, checking_account_rename: @account.checking_account_rename, city_or_town: @account.city_or_town, other_account_name: @account.other_account_name, province_or_state: @account.province_or_state, secritary_name: @account.secritary_name }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
