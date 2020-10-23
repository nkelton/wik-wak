class PostSummaryFactory < Factory
    Result = Struct.new(:response, :errors, :code)

    SUCCESS = "success"
    ERROR = "error"

    POST_NOT_FOUND_ERROR = "Post Summary Not Found"
    
    def initialize
        super
        @result = Result.new(response: nil, errors: [], code: SUCCESS)
    end

    def up_vote(post_id:)
        post_summary = PostSummary.find_by(post_id: post_id)

        if !post_summary
            add_error([POST_NOT_FOUND_ERROR])
            @results.code = ERROR
        end

        if !errors?
            new_up_votes = post_summary.up_votes + Vote::UPVOTE
            @result.response = _update(post_summary: post_summary, params: { up_votes: new_up_votes })
        end

        @results.errors = errors
        @result
    end

    def down_vote(post_id:)
        post_summary = Post.find_by(post_id: post_id)

        if !post_summary
            add_error([POST_NOT_FOUND_ERROR])
            @results.code = ERROR
        end

        if !errors?
            new_down_votes = post_summary.down_vote + Vote::DOWNVOTE
            @result.response = _update(post_summary: post_summary, params: { down_votes: new_down_votes })
        end

        @results.errors = errors
        @result
    end

    private

    def _update(post_summary:, params:)
        post_summary.update(params)
    end

end