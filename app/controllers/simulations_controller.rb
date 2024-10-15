# app/controllers/simulations_controller.rb
class SimulationsController < ApplicationController
  def input_form
    # パラメータ取得
    # @index_fund = params[:simulation][:index_fund]
    # @monthly_amount = params[:simulation][:monthly_amount]
    # @start_year = params[:simulation][:start_year]
    # @start_month = params[:simulation][:start_month]
    # @end_year = params[:simulation][:end_year]
    # @end_month = params[:simulation][:end_month]

    # シミュレーションロジック（別途実装）
    @result = simulate(@index_fund, @monthly_amount, @start_year, @start_month, @end_year, @end_month)
  end

  private

  def simulate(index_fund, monthly_amount, start_year, start_month, end_year, end_month)
    # 実際のシミュレーションロジックを実装する
    # 例：外部APIからインデックスファンドの過去データを取得し、計算する
    # （詳細は別のブランチで設定）
  end
end