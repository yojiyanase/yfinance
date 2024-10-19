Rails.application.routes.draw do
  # 株式データ取得のルート
  # get '/stocks', to: 'stocks#index'

  # get '/import_sp500_data', to: 'sp500_data#index'
  # post '/import_sp500_data', to: 'sp500_data#create'

  root 'stocks#index'

  get 'simulations/input_form'
  post 'simulations/calculate', to: 'simulations#calculate' # 重複しているルートを削除
  get 'simulations/result'
end