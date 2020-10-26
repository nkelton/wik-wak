module API
    module V1
      module Defaults
        extend ActiveSupport::Concern
  
        included do
          prefix "api"
          version "v1", using: :path
          default_format :json
          format :json
  
          helpers do
            def permitted_params
              @permitted_params ||= declared(params, 
                 include_missing: false)
            end
  
            def logger
              Rails.logger
            end

            def serialize_response(response)
              ActiveModelSerializers::SerializableResource.new(response).serializable_hash
            end
          end
        end
      end
    end
  end