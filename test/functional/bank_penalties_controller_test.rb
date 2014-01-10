require 'test_helper'

class BankPenaltiesControllerTest < ActionController::TestCase
  setup do
    @bank_penalty = bank_penalties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_penalties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_penalty" do
    assert_difference('BankPenalty.count') do
      post :create, bank_penalty: { amount: @bank_penalty.amount, bank_account: @bank_penalty.bank_account, created_by_id: @bank_penalty.created_by_id, date: @bank_penalty.date }
    end

    assert_redirected_to bank_penalty_path(assigns(:bank_penalty))
  end

  test "should show bank_penalty" do
    get :show, id: @bank_penalty
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_penalty
    assert_response :success
  end

  test "should update bank_penalty" do
    put :update, id: @bank_penalty, bank_penalty: { amount: @bank_penalty.amount, bank_account: @bank_penalty.bank_account, created_by_id: @bank_penalty.created_by_id, date: @bank_penalty.date }
    assert_redirected_to bank_penalty_path(assigns(:bank_penalty))
  end

  test "should destroy bank_penalty" do
    assert_difference('BankPenalty.count', -1) do
      delete :destroy, id: @bank_penalty
    end

    assert_redirected_to bank_penalties_path
  end
end
