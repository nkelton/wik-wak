FactoryBot.define do
    factory :post do
      title { Faker::String.random(length: 1..20) }
      body  { Faker::String.random(length: 10..100)}
      ip { "123.123.123" }
      location { 
        [
          "#{ Faker::Number.decimal(l_digits: 1, r_digits: 1)}",
          "#{Faker::Number.decimal(l_digits: 1, r_digits: 1)}"
        ] 
      }
    end
  end