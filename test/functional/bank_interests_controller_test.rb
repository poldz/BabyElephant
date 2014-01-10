require 'test_helper'

class BankInterestsControllerTest < ActionController::TestCase
  setup do
    @bank_interest = bank_interests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bank_interests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bank_interest" do
    assert_difference('BankInterest.count') do
      post :create, bank_interest: { amount: @bank_interest.amount, bank_account: @bank_interest.bank_account, created_by_id: @bank_interest.created_by_id, date: @bank_interest.date }
    end

    assert_redirected_to bank_interest_path(assigns(:bank_interest))
  end

  test "should show bank_interest" do
    get :show, id: @bank_interest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bank_interest
    assert_response :success
  end

  test "should update bank_interest" do
    put :update, id: @bank_interest, bank_interest: { amount: @bank_interest.amount, bank_account: @bank_interest.bank_account, created_by_id: @bank_interest.created_by_id, date: @bank_interest.date }
    assert_redirected_to bank_interest_path(assigns(:bank_interest))
  end

  test "should destroy bank_interest" do
    assert_difference('BankInterest.count', -1) do
      delete :destroy, id: @bank_interest
    end

    assert_redirected_to bank_interests_path
  end
end
