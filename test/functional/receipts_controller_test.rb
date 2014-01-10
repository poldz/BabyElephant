require 'test_helper'

class ReceiptsControllerTest < ActionController::TestCase
  setup do
    @receipt = receipts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:receipts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create receipt" do
    assert_difference('Receipt.count') do
      post :create, receipt: { created_by_id: @receipt.created_by_id, date: @receipt.date, kingdom_hall_construction_worldwide: @receipt.kingdom_hall_construction_worldwide, local_congregation_expenses: @receipt.local_congregation_expenses, other_1: @receipt.other_1, other_1_amount: @receipt.other_1_amount, other_1_for: @receipt.other_1_for, other_2: @receipt.other_2, other_2_amount: @receipt.other_2_amount, other_2_for: @receipt.other_2_for, total: @receipt.total, worldwide_work: @receipt.worldwide_work }
    end

    assert_redirected_to receipt_path(assigns(:receipt))
  end

  test "should show receipt" do
    get :show, id: @receipt
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @receipt
    assert_response :success
  end

  test "should update receipt" do
    put :update, id: @receipt, receipt: { created_by_id: @receipt.created_by_id, date: @receipt.date, kingdom_hall_construction_worldwide: @receipt.kingdom_hall_construction_worldwide, local_congregation_expenses: @receipt.local_congregation_expenses, other_1: @receipt.other_1, other_1_amount: @receipt.other_1_amount, other_1_for: @receipt.other_1_for, other_2: @receipt.other_2, other_2_amount: @receipt.other_2_amount, other_2_for: @receipt.other_2_for, total: @receipt.total, worldwide_work: @receipt.worldwide_work }
    assert_redirected_to receipt_path(assigns(:receipt))
  end

  test "should destroy receipt" do
    assert_difference('Receipt.count', -1) do
      delete :destroy, id: @receipt
    end

    assert_redirected_to receipts_path
  end
end
