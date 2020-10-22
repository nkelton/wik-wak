class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :message, type: String

  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many :votes
end
