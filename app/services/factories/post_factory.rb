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
    
        def create(post:)
            post = Post.new(post)
    
            if post.save
                @result.response = post
            else
                @result.code = ERROR
                @result.errors = post.errors
            end
    
            @result
        end 
    
    end
end

