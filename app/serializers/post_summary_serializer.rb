class PostSummarySerializer < ActiveModel::Serializer
    attributes :id, :up_votes, :down_votes, :comment_count, :created_at, :updated_at
end