class PaymentService
  attr_reader :payment
  
  def self.pay!(payment)
    obj = new(payment)
    obj.create!
  end
  
  def self.update!(payment)
    obj = new(payment)
    obj.update
  end
  
  def initialize(payment)
    @payment = payment
  end
  
  def create!
    # TODO: MANAGE THE PAYMENT INTO A MORE SOPHISTICATED STATE MACHINE WITH EVENT DRIVEN PROCESSES
    Payment.transaction do 
      Rails.logger.info("PaymentService: Payment ##{payment.uuid} started")
      payment.update_status('received', :sent_at)
      
      return unless post_to_sepa
      
      # TODO: Add the rest of the payment processing within their own scopes (e.g. FeesCalculatorService)
      # calculate_fees
      # calculate_escroll
      # notify_receiver
      # notify_sender
      
    end
  end
  
  def update
    Payment.transaction do 
      Rails.logger.info("PaymentService: Update Payment ##{payment.uuid} started")
      payment.update_status('sent', :sent_at)
      # change_receiver_balance
      # notify_receiver
      # notify_sender
    end
  end
  
  def post_to_sepa
    if SepaRequestService.post(payment)
      Rails.logger.info("PaymentService: Payment ##{payment.uuid} processing by the bank over SEPA")
      payment.update_status('processing_bank', :received_at)
    else
      Rails.logger.info("PaymentService: Payment ##{payment.uuid} failed to process by the bank over SEPA")
      payment.update_status('failed', :failed_at)
    end
  end
end