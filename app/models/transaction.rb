class Transaction < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :value
  validates_numericality_of :value, greater_than: 0
end
