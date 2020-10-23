module SummaryHelper

    def post_summary?
        self.respond_to?(:post)
    end 

    def comment_summary?
        self.respond_to?(:comment)
    end
    
end