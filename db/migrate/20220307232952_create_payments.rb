class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :receiver_full_name, null: false
      t.string :currency, null: false, default: 'EUR'
      t.decimal :amount, precision: 8, scale: 2, default: 0.0
      t.decimal :fees_amount, precision: 8, scale: 2, default: 0.0
      t.string :status, null: false, default: 'pending'
      t.string :payment_method, null: false
      t.integer :escrow, default: 0
      t.string :uuid, null: false, index: true
      t.datetime :sent_at
      t.datetime :received_at
      t.datetime :failed_at
      t.string :iban

      t.timestamps
    end
  end
end
