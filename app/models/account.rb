class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_numericality_of :total, greater_than: 0

  # before_save :generate_number

  # protected

  # def generate_number
  #   number = rand 20000
  # end

end
