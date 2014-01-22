# coding: utf-8
module ApplicationHelper

  def show_menu
    render partial: 'shared/menu' if user_signed_in?
  end

  def show_title(operation)
    "Dados para #{operation}"
  end

  def show_error_message(resource)
    render partial: 'shared/error_message', locals: { resource: resource }
  end

  def show_date(date)
    date.strftime "%d/%m/%y ás %H:%M"
  end

  def operation_type(movimentation)
    op, clazz = case movimentation.operation
    when 'entry' then ['Saque', 'info']
    when 'deposit' then ['Depósito', 'warning']
    end
    render partial: 'shared/operation_type',
      locals: { clazz: clazz, operation: op }
  end

  def transfer_type(transfer, current_user)
    values = if transfer.account_id.eql?(current_user.account.id)
      ['Enviou por Transferência', 'inverse']
    elsif transfer.account_destiny_id.eql?(current_user.account.id)
      ['Recebeu por Transferência', 'success']
    end
    render partial: 'shared/operation_type',
      locals: { clazz: values.last, operation: values.first }
  end

  def table_movimentations(movimentations)
    render partial: 'shared/movimentations',
      locals: { movimentations: movimentations }
  end

  def table_transfers(transfers)
    render partial: 'shared/transfers',
      locals: { transfers: transfers }
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
