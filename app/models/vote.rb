class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ip, type: String
  field :value, type: Integer

  belongs_to :post
  belongs_to :comment
end
