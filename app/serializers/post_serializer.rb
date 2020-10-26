class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :ip, :location, :created_at, :updated_at
    has_one :post_summary, key: :summary, serializer: PostSummarySerializer
    attribute :links do
        id = object.id
        {
          vote: "/api/v1/posts/#{id}/votes"
        }
    end
end