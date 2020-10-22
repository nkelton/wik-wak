class CommentSummary
  include Mongoid::Document
  include Mongoid::Timestamps
  field :up_votes, type: Number
  field :down_votes, type: Number

  belongs_to :comment
end
