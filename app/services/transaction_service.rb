class TransactionService

  def initialize(operation, account, current_user, quantity)
    @operation = operation
    @account = account
    @current_user = current_user
    @quantity = quantity
  end

  def execute
    message = case @operation
    when 'entry' then entry
    when 'deposit' then deposit
    end
    message
  end

  protected

  def entry
    @current_user.account.minus @quantity
  end

  def deposit
    @current_user.account.plus @quantity
  end

end