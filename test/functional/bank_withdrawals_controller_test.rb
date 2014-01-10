require 'test_helper'

class BankWithdrawalsControllerTest < ActionController::TestCase
  setup do
    @bank_withdrawal = bank_withdrawals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_withdrawals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_withdrawal" do
    assert_difference('BankWithdrawal.count') do
      post :create, bank_withdrawal: { amount: @bank_withdrawal.amount, bank_account: @bank_withdrawal.bank_account, created_by_id: @bank_withdrawal.created_by_id, date: @bank_withdrawal.date }
    end

    assert_redirected_to bank_withdrawal_path(assigns(:bank_withdrawal))
  end

  test "should show bank_withdrawal" do
    get :show, id: @bank_withdrawal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_withdrawal
    assert_response :success
  end

  test "should update bank_withdrawal" do
    put :update, id: @bank_withdrawal, bank_withdrawal: { amount: @bank_withdrawal.amount, bank_account: @bank_withdrawal.bank_account, created_by_id: @bank_withdrawal.created_by_id, date: @bank_withdrawal.date }
    assert_redirected_to bank_withdrawal_path(assigns(:bank_withdrawal))
  end

  test "should destroy bank_withdrawal" do
    assert_difference('BankWithdrawal.count', -1) do
      delete :destroy, id: @bank_withdrawal
    end

    assert_redirected_to bank_withdrawals_path
  end
end
