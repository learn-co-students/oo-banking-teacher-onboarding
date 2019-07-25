require "pry"

class Transfer
  # your code here
  attr_accessor :status, :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    (@sender.valid? && @receiver.valid? ? true : false) && (@sender.balance > @amount)
  end

  def execute_transaction
    # binding.pry
    if @status != "complete" && valid?
      @sender.withdraw(@amount)
      @receiver.deposit(@amount)
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance." 
    end
  end

  def reverse_transfer
    if status == "complete"
      @sender.deposit(@amount)
      @receiver.withdraw(@amount)
      @status = "reversed"
    end
  end
end
