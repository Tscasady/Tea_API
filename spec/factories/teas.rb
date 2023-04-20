FactoryBot.define do
  factory :tea do
    title { 'Green' }
    description { Faker::Lorem.sentence }
    temperature { 190.0 }
    brew_time { 2 }
  end
end
