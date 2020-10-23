json.extract! post, :id, :title, :body, :created_at, :updated_at
if @with_summary
    json.summary do 
        if post.post_summary
           json.up_votes post.post_summary.up_votes
           json.down_votes post.post_summary.down_votes
        end
    end
end
json.url post_url(post, format: :json)
