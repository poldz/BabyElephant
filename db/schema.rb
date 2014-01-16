# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140116062648) do

  create_table "accounting_periods", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "checking_account_rename"
    t.string   "other_account_name"
    t.decimal  "receipts_balance_forward",                :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "checking_balance_forward",                :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "other_account_balance_forward",           :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_funds_at_bom",                      :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_funds_at_eom",                      :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_funds_rfsp",                        :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_funds_atcce",                       :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "surplus_deficit",                         :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_receipts",                          :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "total_expenditures",                      :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "for_worldwide_work",                      :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "for_kingdom_hall_construction_worldwide", :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                              :null => false
    t.datetime "updated_at",                                                                              :null => false
  end

  add_index "accounting_periods", ["account_id"], :name => "index_accounting_periods_on_account_id"
  add_index "accounting_periods", ["created_by_id"], :name => "index_accounting_periods_on_created_by_id"
  add_index "accounting_periods", ["date"], :name => "index_accounting_periods_on_date"
  add_index "accounting_periods", ["user_id"], :name => "index_accounting_periods_on_user_id"

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "account_name"
    t.string   "account_type"
    t.string   "account_number"
    t.string   "city_or_town"
    t.string   "province_or_state"
    t.string   "account_servant_name"
    t.string   "secritary_name"
    t.string   "checking_account_rename"
    t.string   "other_account_name"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "bank_deposits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
    t.string   "source_of_fund"
    t.integer  "bank_withdrawal_id"
  end

  add_index "bank_deposits", ["account_id"], :name => "index_bank_deposits_on_account_id"
  add_index "bank_deposits", ["accounting_period_id"], :name => "index_bank_deposits_on_accounting_period_id"
  add_index "bank_deposits", ["created_by_id"], :name => "index_bank_deposits_on_created_by_id"
  add_index "bank_deposits", ["date"], :name => "index_bank_deposits_on_date"
  add_index "bank_deposits", ["user_id"], :name => "index_bank_deposits_on_user_id"

  create_table "bank_fees", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.string   "description"
    t.string   "notes"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_fees", ["account_id"], :name => "index_bank_fees_on_account_id"
  add_index "bank_fees", ["accounting_period_id"], :name => "index_bank_fees_on_accounting_period_id"
  add_index "bank_fees", ["created_by_id"], :name => "index_bank_fees_on_created_by_id"
  add_index "bank_fees", ["date"], :name => "index_bank_fees_on_date"
  add_index "bank_fees", ["user_id"], :name => "index_bank_fees_on_user_id"

  create_table "bank_interests", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_interests", ["account_id"], :name => "index_bank_interests_on_account_id"
  add_index "bank_interests", ["accounting_period_id"], :name => "index_bank_interests_on_accounting_period_id"
  add_index "bank_interests", ["created_by_id"], :name => "index_bank_interests_on_created_by_id"
  add_index "bank_interests", ["date"], :name => "index_bank_interests_on_date"
  add_index "bank_interests", ["user_id"], :name => "index_bank_interests_on_user_id"

  create_table "bank_other_transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.string   "description"
    t.string   "notes"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.string   "transaction_type"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_other_transactions", ["account_id"], :name => "index_bank_other_transactions_on_account_id"
  add_index "bank_other_transactions", ["accounting_period_id"], :name => "index_bank_other_transactions_on_accounting_period_id"
  add_index "bank_other_transactions", ["created_by_id"], :name => "index_bank_other_transactions_on_created_by_id"
  add_index "bank_other_transactions", ["date"], :name => "index_bank_other_transactions_on_date"
  add_index "bank_other_transactions", ["user_id"], :name => "index_bank_other_transactions_on_user_id"

  create_table "bank_penalties", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.string   "description"
    t.string   "notes"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_penalties", ["account_id"], :name => "index_bank_penalties_on_account_id"
  add_index "bank_penalties", ["accounting_period_id"], :name => "index_bank_penalties_on_accounting_period_id"
  add_index "bank_penalties", ["created_by_id"], :name => "index_bank_penalties_on_created_by_id"
  add_index "bank_penalties", ["date"], :name => "index_bank_penalties_on_date"
  add_index "bank_penalties", ["user_id"], :name => "index_bank_penalties_on_user_id"

  create_table "bank_taxes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_taxes", ["account_id"], :name => "index_bank_taxes_on_account_id"
  add_index "bank_taxes", ["accounting_period_id"], :name => "index_bank_taxes_on_accounting_period_id"
  add_index "bank_taxes", ["created_by_id"], :name => "index_bank_taxes_on_created_by_id"
  add_index "bank_taxes", ["date"], :name => "index_bank_taxes_on_date"
  add_index "bank_taxes", ["user_id"], :name => "index_bank_taxes_on_user_id"

  create_table "bank_withdrawals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "bank_account"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "bank_withdrawals", ["account_id"], :name => "index_bank_withdrawals_on_account_id"
  add_index "bank_withdrawals", ["accounting_period_id"], :name => "index_bank_withdrawals_on_accounting_period_id"
  add_index "bank_withdrawals", ["created_by_id"], :name => "index_bank_withdrawals_on_created_by_id"
  add_index "bank_withdrawals", ["date"], :name => "index_bank_withdrawals_on_date"
  add_index "bank_withdrawals", ["user_id"], :name => "index_bank_withdrawals_on_user_id"

  create_table "expenses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "bank_withdrawal_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "source_of_fund"
    t.string   "description"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.string   "notes"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "expenses", ["account_id"], :name => "index_expenses_on_account_id"
  add_index "expenses", ["accounting_period_id"], :name => "index_expenses_on_accounting_period_id"
  add_index "expenses", ["bank_withdrawal_id"], :name => "index_expenses_on_bank_withdrawal_id"
  add_index "expenses", ["created_by_id"], :name => "index_expenses_on_created_by_id"
  add_index "expenses", ["date"], :name => "index_expenses_on_date"
  add_index "expenses", ["user_id"], :name => "index_expenses_on_user_id"

  create_table "receipts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.decimal  "worldwide_work",                      :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "kingdom_hall_construction_worldwide", :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "local_congregation_expenses",         :precision => 12, :scale => 2, :default => 0.0
    t.string   "other_1"
    t.decimal  "other_1_amount",                      :precision => 12, :scale => 2, :default => 0.0
    t.string   "other_1_for"
    t.string   "other_2"
    t.decimal  "other_2_amount",                      :precision => 12, :scale => 2, :default => 0.0
    t.string   "other_2_for"
    t.decimal  "total",                               :precision => 12, :scale => 2, :default => 0.0
    t.string   "account_servant_name"
    t.string   "verified_by"
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
  end

  add_index "receipts", ["account_id"], :name => "index_receipts_on_account_id"
  add_index "receipts", ["accounting_period_id"], :name => "index_receipts_on_accounting_period_id"
  add_index "receipts", ["created_by_id"], :name => "index_receipts_on_created_by_id"
  add_index "receipts", ["date"], :name => "index_receipts_on_date"
  add_index "receipts", ["user_id"], :name => "index_receipts_on_user_id"

  create_table "remittances", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "accounting_period_id"
    t.integer  "bank_withdrawal_id"
    t.integer  "created_by_id"
    t.date     "date"
    t.string   "source_of_fund"
    t.string   "remittance_type"
    t.string   "description"
    t.decimal  "amount",               :precision => 12, :scale => 2, :default => 0.0
    t.string   "notes"
    t.datetime "created_at",                                                           :null => false
    t.datetime "updated_at",                                                           :null => false
  end

  add_index "remittances", ["account_id"], :name => "index_remittances_on_account_id"
  add_index "remittances", ["accounting_period_id"], :name => "index_remittances_on_accounting_period_id"
  add_index "remittances", ["bank_withdrawal_id"], :name => "index_remittances_on_bank_withdrawal_id"
  add_index "remittances", ["created_by_id"], :name => "index_remittances_on_created_by_id"
  add_index "remittances", ["date"], :name => "index_remittances_on_date"
  add_index "remittances", ["user_id"], :name => "index_remittances_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",             :default => "", :null => false
    t.string   "last_name",              :default => "", :null => false
    t.string   "middle_name",            :default => "", :null => false
    t.string   "address",                :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 10
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
