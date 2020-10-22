json.extract! post_summary, :id, :up_votes, :down_votes, :created_at, :updated_at
json.url post_summary_url(post_summary, format: :json)
