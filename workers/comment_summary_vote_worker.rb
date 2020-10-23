class CommentSummaryVoteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(vote)
        if vote["value"] == Vote::UPVOTE
            CommentSummaryFactory.up_vote(comment_id: vote["comment_id"]["$oid"])
        elsif vote["value"] == Vote::DOWNVOTE
            CommentSummaryFactory.down_vote(comment_id: vote["comment_id"]["$oid"])
        end 
    end
  end