class PostSerializer < ActiveModel::Serializer

    attributes :id, :title, :body, :ip, :location, :created_at, :updated_at
  end