FactoryBot.define do
    factory :up_vote do
        ip { "123.123.123" }
        value  { Vote::UPVOTE }
    end

    factory :down_vote do
        ip { "123.123.123" }
        value  { Vote::DWONVOTE }
    end
  end