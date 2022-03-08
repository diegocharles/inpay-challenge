module Api::V1
  class DisbursementsController < ApplicationController
    
    # GET /disbursements
    def index
      # TODO: OBVIOUSLY IT WOULD BE SCOPED WITHIN THE LOGGED IN USER IN REAL WORLD
      @payments = Payment.all
      
      Rails.logger.info("API::V1::DisbursementsController: #{@payments.count} payments found")
    end
    
    # POST /disbursements
    # TODO: THE AUTHENTICATION WOULD BE DONE IN REAL WORLD
    def create
      @payment = Payment.new(payment_params)
      Rails.logger.info("API::V1::DisbursementsController#create: Payment ##{@payment.uuid} started")
      
      if @payment.save
        PaymentService.pay!(@payment)
        
        Rails.logger.info("API::V1::DisbursementsController: Payment ##{@payment.uuid} created")
        render status: :created
      else
        Rails.logger.info("API::V1::DisbursementsController: Payment ##{@payment.uuid} failed with #{@payment.errors.full_messages}")
      end
    end
    
    # PATCH /disbursements/:uuid
    # TODO: I'm make the assumption that the bank or SEPA will send us one request to us telling when the money is received
    def update
      # TODO: Run this in a background process
      @payment = Payment.find_by(uuid: params[:id])
      Rails.logger.info("API::V1::DisbursementsController#update: Payment ##{@payment.uuid} started")
      
      head :ok if PaymentService.update!(@payment)
    end
    
    protected
    
    def payment_params
      params.require(:payment).permit(:receiver_full_name, :currency, :amount, :iban, :payment_method)
    end
  end
end
