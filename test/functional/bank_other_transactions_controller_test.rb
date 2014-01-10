require 'test_helper'

class BankOtherTransactionsControllerTest < ActionController::TestCase
  setup do
    @bank_other_transaction = bank_other_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_other_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_other_transaction" do
    assert_difference('BankOtherTransaction.count') do
      post :create, bank_other_transaction: { amount: @bank_other_transaction.amount, bank_account: @bank_other_transaction.bank_account, created_by_id: @bank_other_transaction.created_by_id, date: @bank_other_transaction.date, trancaction_type: @bank_other_transaction.trancaction_type }
    end

    assert_redirected_to bank_other_transaction_path(assigns(:bank_other_transaction))
  end

  test "should show bank_other_transaction" do
    get :show, id: @bank_other_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_other_transaction
    assert_response :success
  end

  test "should update bank_other_transaction" do
    put :update, id: @bank_other_transaction, bank_other_transaction: { amount: @bank_other_transaction.amount, bank_account: @bank_other_transaction.bank_account, created_by_id: @bank_other_transaction.created_by_id, date: @bank_other_transaction.date, trancaction_type: @bank_other_transaction.trancaction_type }
    assert_redirected_to bank_other_transaction_path(assigns(:bank_other_transaction))
  end

  test "should destroy bank_other_transaction" do
    assert_difference('BankOtherTransaction.count', -1) do
      delete :destroy, id: @bank_other_transaction
    end

    assert_redirected_to bank_other_transactions_path
  end
end
