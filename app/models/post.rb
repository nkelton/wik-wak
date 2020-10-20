class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial
  include Mongoid::Pagination

  field :title, type: String
  field :body, type: String
  field :ip, type: String
  field :location, type: Point, sphere: true

  has_many :comments, dependent: :destroy

  sphere_index :location
end
