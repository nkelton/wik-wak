json.extract! comment, :id, :name, :message, :post_id, :parent_id, :created_at, :updated_at
if @with_summary
    json.summary do 
        if comment.comment_summary
           json.up_votes comment.comment_summary.up_votes
           json.down_votes comment.comment_summary.down_votes
        end
    end
end
json.url comment_url(comment, format: :json)
