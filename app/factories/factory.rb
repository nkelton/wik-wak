class Factory
    attr_accessor :errors
    
    def initialize
        @errors = []
    end
    
    def errors?
        @errors.any?
    end

    def add_error(error:)
        @errors << error
    end
end