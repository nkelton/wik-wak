FactoryBot.define do
    factory :vote do
        ip { "123.123.123" }
        value  { [Vote::UPVOTE, Vote::DOWNVOTE].sample }
    end
  end