require 'test_helper'

class BankFeesControllerTest < ActionController::TestCase
  setup do
    @bank_fee = bank_fees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_fees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_fee" do
    assert_difference('BankFee.count') do
      post :create, bank_fee: { amount: @bank_fee.amount, bank_account: @bank_fee.bank_account, created_by_id: @bank_fee.created_by_id, date: @bank_fee.date }
    end

    assert_redirected_to bank_fee_path(assigns(:bank_fee))
  end

  test "should show bank_fee" do
    get :show, id: @bank_fee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_fee
    assert_response :success
  end

  test "should update bank_fee" do
    put :update, id: @bank_fee, bank_fee: { amount: @bank_fee.amount, bank_account: @bank_fee.bank_account, created_by_id: @bank_fee.created_by_id, date: @bank_fee.date }
    assert_redirected_to bank_fee_path(assigns(:bank_fee))
  end

  test "should destroy bank_fee" do
    assert_difference('BankFee.count', -1) do
      delete :destroy, id: @bank_fee
    end

    assert_redirected_to bank_fees_path
  end
end
