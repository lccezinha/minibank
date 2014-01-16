# coding: utf-8
class InsuficientMoney < Exception
end

class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_numericality_of :total, greater_than: 0

  def minus(value)
    begin
      check_total(value)
    rescue => e
      e.message
    else
      self.total -= value
      return self if self.save
    end
  end

  def plus(value)
    self.total += value
    self.save
  end

  # before_save :generate_number

  protected

  def check_total(value)
    raise InsuficientMoney, 'Saldo insuficiente.' if self.total < value
  end

  # def generate_number
  #   number = rand 20000
  # end

end
