class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :body, :ip, :location, :created_at, :updated_at
    has_one :post_summary, key: :summary, serializer: PostSummarySerializer
end