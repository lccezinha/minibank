# coding: utf-8
class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_numericality_of :total, greater_than: 0

  def minus(value)
    raise Exception, 'Saldo insuficiente.' if total < value
    self.total -= value
    self.save
  end

  def plus(value)
    self.total += value
    self.save
  end

  # before_save :generate_number

  # protected

  # def generate_number
  #   number = rand 20000
  # end

end
