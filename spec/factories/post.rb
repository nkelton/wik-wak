FactoryBot.define do
    factory :post do
      title { "Post Title!" }
      body  { "Blah Blah Blah" }
      ip { "123.123.123" }
      location { ["123.456", "7.89"] }
    end
  end