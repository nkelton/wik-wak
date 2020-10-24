class SummaryFactory < Factory
    def build(klass, *args)
        case klass
        when PostSummary.class
            PostSummaryFactory.new(*args)
        when CommentSummary.class
            CommentSummaryFactory.new(*args)
        end 
    end
end