require 'rails_helper'

RSpec.describe "DisbursementsApis", type: :request do
  let(:headers) do 
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  end
  
  describe "GET /api/v1/disbursements" do
    before do 
      create_list(:payment, 3)
    end
    
    it 'returns the given and received likes' do
      response = get api_v1_disbursements_path, headers: headers
      
      json = JSON.parse(response.body)

      expect(json['payments'].size).to be_eql(3)
    end
  end
  
  describe "POST /api/v1/disbursements" do
    let(:payment_params) do
    {
      payment: {
        receiver_full_name: 'John Doe',
        currency: 'EUR',
        amount: 100,
        iban: 'DE89370400440532013000',
        payment_method: 'bank_transfer'
      }
    }
  end
  
    it 'creates a new payment' do
      response = post(api_v1_disbursements_path, payment_params, headers: headers)
      
      expected_keys = %w(uuid receiver_full_name currency amount iban status sent_at received_at).sort
      
      expect(response.status).to be_eql(201)
      expect(JSON.parse(response.body).dig('payment').keys.sort).to be_eql(expected_keys)
    end
  end
  
  describe "PATCH/PUT /api/v1/disbursements/uuid" do
    let!(:payment) { create(:payment, status: 'processing_bank') }
    
    it 'creates a new payment' do
      response = patch(api_v1_disbursement_path(payment.uuid), headers: headers)
      
      expect(response.status).to be_eql(200)
    end
  end
end
