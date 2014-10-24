Rails.application.routes.draw do

  get "home/index"
  devise_for :users
  root :to => "home#index"

  resources :accounts do
    resources :accounting_periods do

      member do
        get 'generate_report'
        get 'forecast'
        get 'summary'
      end


      resources :receipts
      resources :bank_deposits

      resources :bank_withdrawals  do
        resources :remittances
        resources :expenses
      end

      resources :bank_interests
      resources :bank_taxes
      resources :bank_penalties
      resources :bank_fees
      resources :bank_other_transactions
      resources :remittances
      resources :expenses

    end
  end

end
