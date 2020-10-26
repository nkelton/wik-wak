class CommentSerializer < ActiveModel::Serializer
    attributes :id, :name, :message, :created_at, :updated_at
    has_one :comment_summary, key: :summary, serializer: CommentSummarySerializer
end