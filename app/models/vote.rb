class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  field :ip, type: String
  field :value, type: Integer

  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  UPVOTE = 1
  DOWNVOTE = -1


  def is_post?
    self.comment == nil && self.post != nil
  end

  def is_comment?
    self.comment != nil && self.post == nil
  end

end
