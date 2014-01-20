# coding: utf-8
class Account < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates_numericality_of :total, greater_than: 0

  def minus(value)
    return false if check_total(value)
    self.total -= value
    self.save
  end

  def plus(value)
    return false if check_quantity(value)
    self.total += value
    self.save
  end

  protected

  def check_total(value)
    self.total < value
  end

  def check_quantity(value)
    value.nil? || value <= 0
  end
end
