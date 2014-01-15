class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  # before_save :generate_number

  # protected

  # def generate_number
  #   number = rand 20000
  # end

end
