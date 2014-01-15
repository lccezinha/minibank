class TransactionService

  def initialize(operation, account, current_user, value)
    @operation = operation
    @account = account
    @current_user = current_user
    @value = value
  end

  def execute
    case @operation
    when 'booty' then booty
    when 'deposit' then deposit
    end
  end

  protected

  def booty
    @current_user.account.minus @value
  end

  def deposit
    @current_user.account.plus @value
  end

end