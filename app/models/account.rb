# == Schema Information
#
# Table name: accounts
#
#  id         :integer          not null, primary key
#  balance    :decimal(, )
#  full_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  has_many :payments, inverse_of: :receiver
end
