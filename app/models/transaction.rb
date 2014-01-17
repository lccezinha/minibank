class Transaction < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :value
  validates_numericality_of :value, greater_than: 0

  scope :by_period, ->(start_date, end_date) {
    where "date(created_at) BETWEEN ? AND ?", start_date, end_date
  }
end
