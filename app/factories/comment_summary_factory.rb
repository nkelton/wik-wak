class CommentSummaryFactory < Factory
    Result = Struct.new(:response, :errors, :code)

    SUCCESS = "success"
    ERROR = "error"

    COMMENT_NOT_FOUND_ERROR = "Comment Summary Not Found"
    
    def initialize
        super
        @result = Result.new(response: nil, errors: [], code: SUCCESS)
    end

    def up_vote(comment_id:)
        comment_summary = comment_summary.find_by(comment_id: comment_id)

        if !comment_summary
            add_error([COMMENT_NOT_FOUND_ERROR])
            @results.code = ERROR
        end

        if !errors?
            new_up_votes = comment_summary.up_votes + Vote::UPVOTE
            @result.response = _update(comment_summary: comment_summary, params: { up_votes: new_up_votes })
        end

        @results.errors = errors
        @result
    end

    def down_vote(comment_id:)
        comment_summary = CommentSummary.find_by(comment_id: comment_id)

        if !comment_summary
            add_error([COMMENT_NOT_FOUND_ERROR])
            @results.code = ERROR
        end

        if !errors?
            new_down_votes = comment_summary.down_vote + Vote::DOWNVOTE
            @result.response = _update(comment_summary: comment_summary, params: { down_votes: new_down_votes })
        end

        @results.errors = errors
        @result
    end

    private

    def _update(comment_summary:, params:)
        comment_summary.update(params)
    end

end