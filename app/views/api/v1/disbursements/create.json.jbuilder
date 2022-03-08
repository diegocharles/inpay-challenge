json.payment do 
  json.(@payment, :uuid, :receiver_full_name,:currency,:amount,:iban,:status,:sent_at,:received_at)
end