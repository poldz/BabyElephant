require 'test_helper'

class BankTaxesControllerTest < ActionController::TestCase
  setup do
    @bank_taxis = bank_taxes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_taxes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_taxis" do
    assert_difference('BankTax.count') do
      post :create, bank_taxis: { amount: @bank_taxis.amount, bank_account: @bank_taxis.bank_account, created_by_id: @bank_taxis.created_by_id, date: @bank_taxis.date }
    end

    assert_redirected_to bank_taxis_path(assigns(:bank_taxis))
  end

  test "should show bank_taxis" do
    get :show, id: @bank_taxis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_taxis
    assert_response :success
  end

  test "should update bank_taxis" do
    put :update, id: @bank_taxis, bank_taxis: { amount: @bank_taxis.amount, bank_account: @bank_taxis.bank_account, created_by_id: @bank_taxis.created_by_id, date: @bank_taxis.date }
    assert_redirected_to bank_taxis_path(assigns(:bank_taxis))
  end

  test "should destroy bank_taxis" do
    assert_difference('BankTax.count', -1) do
      delete :destroy, id: @bank_taxis
    end

    assert_redirected_to bank_taxes_path
  end
end
