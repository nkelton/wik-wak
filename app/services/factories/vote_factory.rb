module Factories
    class VoteFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        POST_NOT_FOUND_ERROR = "Post Not Found"
        POST_NOT_CREATED = "Post Could Not Be Created"
    
        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end 
    
        def create(vote_attributes:)
            vote = Vote.new(vote_attributes)
    
            if vote.save
                @result.response = vote
                _queue_summary_vote(vote: vote)
            else
                @result.code = ERROR
                @result.errors = vote.errors
            end
    
            @result
        end 


        private 

        def _queue_summary_vote(vote:)
            if vote.is_post?
                PostSummaryVoteWorker.perform_async({ value: vote.value, post_id: vote.post_id })
            elsif vote.is_comment?
                CommentSummaryVoteWorker.perform_async({ value: vote.value, comment_id: vote.comment_id })
            end 
        end
    end
end

