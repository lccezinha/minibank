# coding: utf-8
module ApplicationHelper

  def show_menu
    render partial: 'shared/menu' if user_signed_in?
  end

  def show_submit_action(operation)
    case operation
    when 'booty' then 'Sacar'
    when 'deposit' then 'Depositar'
    end
  end

  def show_title(operation)
    op = case operation
    when 'booty' then 'Saque'
    when 'deposit' then 'Depósito'
    end
    "Dados para #{op}"
  end

  def show_date(date)
    date.strftime "%d/%m/%y ás %H:%M"
  end

  def operation_type(operation)
    op, clazz = case operation
    when 'booty' then ['Saque', 'info']
    when 'deposit' then ['Depósito', 'warning']
    end
    render partial: 'shared/operation_type',
      locals: { clazz: clazz, operation: op }
  end

  def table_transactions(transactions)
    render partial: 'shared/transactions',
      locals: { transactions: transactions }
  end

  def show_flash(flash)
    unless flash.nil? || flash.empty?
      clazz = case flash.first.first
        when :notice ; 'alert alert-success'
        when :alert ; 'alert alert-error'
        when :warning ; 'alert alert-warning'
      end
      render partial: 'shared/flash_message',
        locals: { clazz: clazz, message: flash.first.second }
    end
  end

  def to_real(value)
    number_to_currency(value, unit: "R$ ", separator: ".")
  end

end
