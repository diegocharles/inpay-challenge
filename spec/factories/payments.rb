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
FactoryBot.define do
  factory :payment do
    receiver_full_name { Faker::Name.name }
    currency { 'EUR' }
    iban { Faker::Bank.iban }
    amount { Faker::Number.decimal(2) }
    fees_amount { Faker::Number.decimal(2) }
    status { 'pending' }
    payment_method { 'direct_debit' }
    escrow { 5 }
    uuid { SecureRandom.uuid }
    sent_at { nil }
    received_at { nil }
    failed_at { nil }    
  end
end
