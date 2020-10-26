class CommentSerializer < ActiveModel::Serializer
    attributes :id, :name, :message, :created_at, :updated_at
    has_one :comment_summary, key: :summary, serializer: CommentSummarySerializer
    attribute :links do
        id = object.id
        {
          vote: "/api/v1/comments/#{id}/votes"
        }
    end
end