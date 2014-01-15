class TransactionService

  def initialize(transaction)
    @transaction = transaction
  end

  def execute
    # deve retorar as msg do flash
    case @transaction.operation
    when 'booty' then minus
    when 'deposit' then plus
    end
    # @trasaction.save
  end

  protected

  def minus
    p ['minus']
    # @trasaction.account.total -= @value
  end

  def plus
    p ['plus']
    # @trasaction.account.total += @value
  end

end