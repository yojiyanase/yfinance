class Stock < ApplicationRecord
  validates :date, presence: true
  # カスタムバリデーション (必要に応じて)
  validate :validate_date_format

  private

  def validate_date_format
    errors.add(:date, "invalid date format") unless date.is_a?(Date)
  end
end