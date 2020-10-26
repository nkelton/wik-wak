module Factories
    class CommentFactory < Factory
        Result = Struct.new(:response, :errors, :code, keyword_init: true)
    
        SUCCESS = "success"
        ERROR = "error"
    
        def initialize
            super
            @result = Result.new(response: nil, errors: [], code: SUCCESS)
        end 
    
        def create(comment:)
            comment = Comment.new(comment)
    
            if comment.save
                @result.response = comment
            else
                @result.code = ERROR
                @result.errors = comment.errors
            end
    
            @result
        end   
    end
end