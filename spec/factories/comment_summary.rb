FactoryBot.define do
    factory :comment_summary do
        up_votes { Faker::Number.number(digits: 2) }
        down_votes { Faker::Number.number(digits: 2) }
    end
  end