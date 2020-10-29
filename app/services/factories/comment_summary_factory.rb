module Factories
    class CommentSummaryFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        COMMENT_SUMMARY_NOT_FOUND_ERROR = "Comment Summary Not Found"

        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end

        def create(comment_id:)
            comment_summary_attributes = {
                comment_id: comment_id,
                up_votes: 0,
                down_votes: 0,
                comment_count: 0
            }

            comment_summary = CommentSummary.new(comment_summary_attributes)

            if comment_summary.save
                @result.response = comment_summary
            else 
                @result.code = ERROR
                @result.errors = comment_summary.errors 
            end

            @result
        end
    
        def up_vote(comment_id:)
            comment_summary = CommentSummary.find_by(comment_id: comment_id)
    
            if !comment_summary
                @result.errors << [COMMENT_SUMMARY_NOT_FOUND_ERROR]
                @result.code = ERROR
            end
    
            if @result.code != ERROR 
                new_up_votes = comment_summary.up_votes + Vote::UPVOTE
                @result.response = _update(comment_summary: comment_summary, params: { up_votes: new_up_votes })
            end
    
            @result
        end
    
        def down_vote(comment_id:)
            comment_summary = CommentSummary.find_by(comment_id: comment_id)
    
            if !comment_summary
                @result.errors << [COMMENT_SUMMARY_NOT_FOUND_ERROR]
                @result.code = ERROR
            end
    
            if @result.code != ERROR
                new_down_votes = comment_summary.down_votes + ( -1 * Vote::DOWNVOTE )
                @result.response = _update(comment_summary: comment_summary, params: { down_votes: new_down_votes })
            end
    
            @result
        end

        def increment_comment_count(comment_id:)
            comment_summary = CommentSummary.find_by(comment_id: comment_id)
    
            if !comment_summary
                @result.errors << [COMMENT_SUMMARY_NOT_FOUND_ERROR]
                @result.code = ERROR
            end
    
            if @result.code != ERROR
                new_comment_count = comment_summary.comment_count + 1
                @result.response = _update(comment_summary: comment_summary, params: { comment_count: new_comment_count })
            end

            @result
        end
    
        private
    
        def _update(comment_summary:, params:)
            comment_summary.update(params)
        end
    
    end
end
