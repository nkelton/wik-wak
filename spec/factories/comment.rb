FactoryBot.define do
    factory :comment do
        name { Faker::String.random(length: 1..20) }
        message  { Faker::String.random(length: 10..100)}
    end
  end