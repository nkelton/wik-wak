class IncrementCommentCountWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    #TODO add logging 
    def perform(comment)
        if comment["parent_id"].nil?
            Factories::PostSummaryFactory.new.increment_comment_count(post_id: comment["post_id"]["$oid"])
        else
            Factories::CommentSummaryFactory.new.increment_comment_count(comment_id: comment["parent_id"]["$oid"])
        end 
    end
  end