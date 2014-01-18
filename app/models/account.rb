# coding: utf-8
class InsuficientMoney < Exception; end

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
      'Saque realizado com sucesso.' if self.save
    end
  end

  def plus(value)
    begin
      check_quantity(value)
    rescue => e
      e.message
    else
      self.total += value
      'Depósito realizado com sucesso.' if self.save
    end
  end

  protected

  def check_total(value)
    raise InsuficientMoney, 'Saldo insuficiente.' if self.total < value
  end

  def check_quantity(value)
    raise InsuficientMoney, 'Valor inválido para depósito.' if value <= 0
  end
end
