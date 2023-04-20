FactoryBot.define do
  factory :tea do
    title { 'Green' }
    description { Faker.lorem.sentence }
    temperature { 190.0 }
    temperature { 2 }
  end
end
