class PostSummarySerializer < ActiveModel::Serializer
    attributes :id, :up_votes, :down_votes, :created_at, :updated_at
end