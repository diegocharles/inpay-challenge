class SepaRequestService
  def self.post(payment)
    # TODO: Implement the Sepa Request API call
      Rails.logger.info("SepaRequestService: Payment ##{payment.uuid} posted to SEPA")
      return true
  rescue Sepa::Error => e
    Rails.logger.info("SepaRequestService: Sepa::Error: #{e.message}")
    return false
  end
end