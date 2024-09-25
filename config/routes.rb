Rails.application.routes.draw do
  # 株式データ取得のルート
  # get '/stocks', to: 'stocks#index'

  # get '/import_sp500_data', to: 'sp500_data#index'
  # post '/import_sp500_data', to: 'sp500_data#create'

  root 'stocks#index'
end