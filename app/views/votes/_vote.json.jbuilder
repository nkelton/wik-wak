json.extract! vote, :id, :ip, :value, :comment_id, :post_id, :created_at, :updated_at
json.url vote_url(vote, format: :json)
