require 'test_helper'

class AccountingPeriodsControllerTest < ActionController::TestCase
  setup do
    @accounting_period = accounting_periods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounting_periods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accounting_period" do
    assert_difference('AccountingPeriod.count') do
      post :create, accounting_period: { checking_account_rename: @accounting_period.checking_account_rename, checking_balance_forward: @accounting_period.checking_balance_forward, created_by_id: @accounting_period.created_by_id, date: @accounting_period.date, for_kingdom_hall_construction_worldwide: @accounting_period.for_kingdom_hall_construction_worldwide, for_worldwide_work: @accounting_period.for_worldwide_work, other_account_balance_forward: @accounting_period.other_account_balance_forward, other_account_name: @accounting_period.other_account_name, receipts_balance_forward: @accounting_period.receipts_balance_forward, surplus_deficit: @accounting_period.surplus_deficit, total_expenditures: @accounting_period.total_expenditures, total_funds_at_bom: @accounting_period.total_funds_at_bom, total_funds_at_eom: @accounting_period.total_funds_at_eom, total_funds_atcce: @accounting_period.total_funds_atcce, total_funds_rfsp: @accounting_period.total_funds_rfsp, total_receipts: @accounting_period.total_receipts }
    end

    assert_redirected_to accounting_period_path(assigns(:accounting_period))
  end

  test "should show accounting_period" do
    get :show, id: @accounting_period
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accounting_period
    assert_response :success
  end

  test "should update accounting_period" do
    put :update, id: @accounting_period, accounting_period: { checking_account_rename: @accounting_period.checking_account_rename, checking_balance_forward: @accounting_period.checking_balance_forward, created_by_id: @accounting_period.created_by_id, date: @accounting_period.date, for_kingdom_hall_construction_worldwide: @accounting_period.for_kingdom_hall_construction_worldwide, for_worldwide_work: @accounting_period.for_worldwide_work, other_account_balance_forward: @accounting_period.other_account_balance_forward, other_account_name: @accounting_period.other_account_name, receipts_balance_forward: @accounting_period.receipts_balance_forward, surplus_deficit: @accounting_period.surplus_deficit, total_expenditures: @accounting_period.total_expenditures, total_funds_at_bom: @accounting_period.total_funds_at_bom, total_funds_at_eom: @accounting_period.total_funds_at_eom, total_funds_atcce: @accounting_period.total_funds_atcce, total_funds_rfsp: @accounting_period.total_funds_rfsp, total_receipts: @accounting_period.total_receipts }
    assert_redirected_to accounting_period_path(assigns(:accounting_period))
  end

  test "should destroy accounting_period" do
    assert_difference('AccountingPeriod.count', -1) do
      delete :destroy, id: @accounting_period
    end

    assert_redirected_to accounting_periods_path
  end
end
