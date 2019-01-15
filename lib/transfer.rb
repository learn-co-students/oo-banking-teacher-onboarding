class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def complete?
    @status == "complete"
  end

  def execute_transaction
    if self.valid? && @sender.balance >= @amount && !self.complete?
      @sender.withdraw(@amount)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      self.reject_transfer
    end
  end

  def reverse_transfer
    if self.valid? && @receiver.balance >= @amount && self.complete?
      @receiver.withdraw(@amount)
      @sender.deposit(@amount)
      @status = "reversed"
    else
      self.reject_transfer
    end
  end

  def reject_transfer
    @status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
end
