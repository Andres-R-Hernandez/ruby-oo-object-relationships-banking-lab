class Transfer

  attr_accessor :sender, :receiver, :status, :amount

    def initialize(sender, receiver, amount)
      @sender=sender
      @receiver=receiver
      @amount=amount
      @status="pending"
    end

    def valid?
      self.sender.valid? && self.receiver.valid?
    end

    def execute_transaction
      if self.status=="pending"
        if self.sender.balance>self.amount && self.valid?
          self.receiver.deposit(self.amount)
          self.sender.deposit(-1*self.amount)
          self.status="complete"
        else
          self.status="rejected"
          "Transaction rejected. Please check your account balance."
        end
      end
    end

    def reverse_transfer
      if self.status=="complete"
        self.receiver.deposit(-1*self.amount)
        self.sender.deposit(*self.amount)
        self.status="reversed"
      end
    end

end
