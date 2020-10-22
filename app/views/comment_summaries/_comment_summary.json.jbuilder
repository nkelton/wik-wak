json.extract! comment_summary, :id, :up_votes, :down_votes, :created_at, :updated_at
json.url comment_summary_url(comment_summary, format: :json)
