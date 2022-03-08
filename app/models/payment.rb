# == Schema Information
#
# Table name: payments
#
#  id                 :integer          not null, primary key
#  amount             :decimal(8, 2)    default(0.0)
#  currency           :string           default("EUR"), not null
#  escrow             :integer          default(0)
#  failed_at          :datetime
#  fees_amount        :decimal(8, 2)    default(0.0)
#  iban               :string
#  payment_method     :string           not null
#  received_at        :datetime
#  receiver_full_name :string           not null
#  sent_at            :datetime
#  status             :string           default("pending"), not null
#  uuid               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_payments_on_uuid  (uuid)
#
class Payment < ApplicationRecord
  
  # Associations
  # RECEIVER FULL NAME WOULD PROBABLY BE SET ONTO ACCOUNT CLASS IN REAL WORLD INSTEAD A REGULAR COLUMN IN THE PAYMENT CLASS
  # belongs_to :account
  
  # Validations
  validates :receiver_full_name, presence: true
  validates :currency, inclusion: { in: %w(EUR USD) }
  validates :amount, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w(pending received processing_bank sent failed) }
  validates :iban, presence: true

  # Callbacks
  before_create :generate_uuid
  
  def update_status(status, time_column)
    update!(status: status)
    touch(time_column)
  end
    
  private
  
  def generate_uuid
    uuid = SecureRandom.uuid
    while self.class.exists?(uuid: uuid)
      uuid = SecureRandom.uuid
    end
    
    self.uuid = uuid
  end
end
