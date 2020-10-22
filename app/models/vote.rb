class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ip, type: String
  field :value, type: Number

  belongs_to :post
  belongs_to :comment
end
