class Factory
    attr_accessor :errors, :logger
    
    def initialize(logger: Logger.new)
        @logger = logger
        @errors = []
    end
    
    def errors?
        @errors.any?
    end

    def add_error(error:)
        @errors << error
    end
end