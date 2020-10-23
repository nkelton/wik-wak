class SummaryFactory < Factory
    def build(object, *args)
        case object.class
        when PostSummary.class
            PostSummaryFactory.new(*args)
        when CommentSummary.class
            CommentSummaryFactory.new(*args)
        end 
    end
end