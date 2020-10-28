module Factories
    class PostSummaryFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        POST_SUMMARY_NOT_FOUND_ERROR = "Post Summary Not Found"
        
        UPVOTES_DEFAULT = 0
        DOWNVOTES_DEFAULT = 0

        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end

        def create(post_id:)
            post_summary_params = {
                post_id: post_id,
                up_votes: UPVOTES_DEFAULT,
                down_votes: DOWNVOTES_DEFAULT
            }

            post_summary = PostSummary.new(post_summary_params)

            if post_summary.save
                @result.response = post_summary
            else 
                @result.code = ERROR
                @result.errors = post_summary.errors 
            end

            @result
        end
    
        #TODO - Can probably just combine this to vote? 
        def up_vote(post_id:)
            post_summary = PostSummary.find_by(post_id: post_id)

            if !post_summary
                @result.errors << [POST_SUMMARY_NOT_FOUND_ERROR]
                @result.code = ERROR
            end
    
            if @result.code != ERROR
                new_up_votes = post_summary.up_votes + Vote::UPVOTE
                @result.response = _update(post_summary: post_summary, params: { up_votes: new_up_votes })
            end

            @result
        end
    
        def down_vote(post_id:)
            post_summary = PostSummary.find_by(post_id: post_id)
    
            if !post_summary
                @result.errors << [POST_SUMMARY_NOT_FOUND_ERROR]
                @result.code = ERROR
            end
    
            if @result.code != ERROR
                new_down_votes = post_summary.down_votes + ( -1 * Vote::DOWNVOTE )
                @result.response = _update(post_summary: post_summary, params: { down_votes: new_down_votes })
            end
    
            @result
        end
    
        private
    
        def _update(post_summary:, params:)
            post_summary.update(params)
        end
    
    end
end