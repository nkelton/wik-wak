FactoryBot.define do
    factory :post_summary do
        up_votes { Faker::Number.number(digits: 2) }
        down_votes { Faker::Number.number(digits: 2) }
        comment_count { Faker::Number.number(digits: 2) }
    end
  end