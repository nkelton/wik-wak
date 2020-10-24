class PostSummaryVoteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(vote)
        if vote["value"] == Vote::UPVOTE
            PostSummaryFactory.new.up_vote(post_id: vote["post_id"]["$oid"])
        elsif vote["value"] == Vote::DOWNVOTE
            PostSummaryFactory.new.down_vote(post_id: vote["post_id"]["$oid"])
        end 
    end

  end