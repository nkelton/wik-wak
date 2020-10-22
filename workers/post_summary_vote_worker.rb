class PostSummaryVoteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    UP_VOTE = 1
    DOWN_VOTE = -1

    def perform(vote)
        post_summary = PostSummary.find_by(post_id: vote["post_id"]["$oid"]) 
    
        if !post_summary
            post_summary = PostSummary.new(up_votes: 0, down_votes: 0, post_id: vote["post_id"]["$oid"])
            post_summary.save!
        end

        if vote["value"] == UP_VOTE
            vote_params = { up_votes: post_summary.up_votes + 1 }
        elsif vote["value"] == DOWN_VOTE
            vote_params = { down_votes: post_summary.down_votes + 1 } 
        end
        
        post_summary.update(vote_params) 
    end
  end