module Factories
    class CommentFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end 
    
        def create(comment_attributes:)
            comment = nil
            begin
                Comment.with_session do |s|
                    s.start_transaction
                    comment = Comment.create!(comment_attributes)
                    _create_comment_summary(comment_id: comment.id)
                    s.commit_transaction
                end
            rescue => error
                @result.errors = [error.message]
                @result.code = ERROR    
            end

            if @result.code != ERROR
                @result.response = comment.reload
                _queue_increment_comment_count(comment: comment)
            end
    
            @result
        end
        
        private 

        def _create_comment_summary(comment_id:)
            comment_summary_result = CommentSummaryFactory.new.create(comment_id: comment_id)
            if comment_summary_result.code != Factories::CommentSummaryFactory::SUCCESS
                #TODO - better errros 
                raise "Could not create comment summary!"
            end
        end 

        def _queue_increment_comment_count(comment:)
            IncrementCommentCountWorker.perform_async({ post_id: comment.post_id, parent_id: comment.parent_id })
        end

    end
end