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
require 'rails_helper'

RSpec.describe Payment, type: :model do
  let!(:payment) { FactoryBot.create(:payment) }
  
  context "Validations" do 
    it { should validate_presence_of(:receiver_full_name) }
    it { should validate_inclusion_of(:currency).in_array(%w(EUR USD)) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
    it { should validate_inclusion_of(:status).in_array(%w(pending received processing_bank sent failed)) }
    it { should validate_presence_of(:iban) }
  end
  
  context "Generating the UUID" do 
    before do 
      payment.update_column(:uuid, 'foobar')
    end
    
    let(:payment_with_same_uuid) { FactoryBot.build(:payment, uuid: 'foobar') }
    
    it 'generates a new UUID for every new payment' do
      payment = FactoryBot.build(:payment, uuid: nil)
      payment.save
      
      expect(payment.uuid).to be_present
    end
    
    it "should generate a new UUID" do
      payment_with_same_uuid.save
      
      expect(payment_with_same_uuid.uuid).not_to eq('foobar')
    end
    
    it 'won\'t generate a new UUID if the UUID is already present on update transactions' do
      payment.update!(status: 'sent')
      expect(payment.uuid).to eq('foobar')
    end
  end
  
  context "updating the status" do
    it 'updates the status' do
      payment.update_status('sent', :sent_at)
      
      expect(payment.status).to eq('sent')
      expect(payment.sent_at).to be_present
    end
  end
end
