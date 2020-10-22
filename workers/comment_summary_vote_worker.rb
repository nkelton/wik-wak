class CommentSummaryVoteWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    UP_VOTE = 1
    DOWN_VOTE = -1

    def perform(vote)
        comment_summary = CommentSummary.find_by(comment_id: vote["comment_id"]["$oid"]) 
    
        if !comment_summary 
            comment_summary = CommentSummary.new(up_votes: 0, down_votes: 0, comment_id: vote["comment_id"]["$oid"])
        end

        if vote["value"] == UP_VOTE
            vote_params = { up_votes: comment_summary.up_votes + 1 }
        elsif vote["value"] == DOWN_VOTE
            vote_params = { down_votes: comment_summary.down_votes + 1 } 
        end
        
        comment_summary.update(vote_params) 
    end
  end