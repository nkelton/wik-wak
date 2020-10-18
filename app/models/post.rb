class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Geospatial

  field :title, type: String
  field :body, type: String
  field :ip, type: String
  field :location, type: Point, sphere: true

  has_many :comments

  sphere_index :location
end
