class CommentSummary
  include Mongoid::Document
  include Mongoid::Timestamps
  field :up_votes, type: Integer
  field :down_votes, type: Integer

  belongs_to :comment
end
