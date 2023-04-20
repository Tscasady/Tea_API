FactoryBot.define do
  factory :subscription do
    tea { create(:tea) }
    customer { create(:customer) }
    title { Faker::Lorem.word }
    price { 5.0 }
    status { 'active' }
    frequency { 2 }
  end
end
