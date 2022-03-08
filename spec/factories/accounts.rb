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
FactoryBot.define do
  factory :account do
    full_name { "MyString" }
    balance { "9.99" }
  end
end
