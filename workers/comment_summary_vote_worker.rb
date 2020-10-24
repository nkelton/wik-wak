class CommentSummaryVoteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(vote)
        if vote["value"] == Vote::UPVOTE
            Factories::CommentSummaryFactory.new.up_vote(comment_id: vote["comment_id"]["$oid"])
        elsif vote["value"] == Vote::DOWNVOTE
            Factories::CommentSummaryFactory.new.down_vote(comment_id: vote["comment_id"]["$oid"])
        end 
    end
  end