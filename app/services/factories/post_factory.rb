module Factories
    class PostFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        POST_NOT_FOUND_ERROR = "Post Not Found"
        POST_NOT_CREATED = "Post Could Not Be Created"
    
        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end 
        #TODO - make transaction like comments
        #TODO - connect to api for posts/comments 
        def create(post_attributes:)
            begin
                Post.with_session do |s|
                    s.start_transaction
                    post = Post.create!(post_attributes)
                    _create_post_summary(post_id: post.id)
    
                    @result.response = post.reload
                    
                    s.commit_transaction
                end
            rescue => error
                @result.errors = [error.message]
                @result.code = ERROR    
            end
    
            @result
        end 

        private 

        def _create_post_summary(post_id:)
            post_summary_result = PostSummaryFactory.new.create(post_id: post_id)
            if post_summary_result.code != Factories::PostSummaryFactory::SUCCESS
                #TODO - better errros 
                raise "Could not create comment summary!"
            end
        end 
    
    end
end

