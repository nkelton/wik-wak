module API
  module V1
    class Comments < Grape::API
      include API::V1::Defaults

      resource :comments do
        route_param :comment_id, type: String do
          desc "Create a vote for a comment"
          params do 
            requires :ip, type: String, desc: "Ip address of the vote"
            requires :value, type: String, desc: "Value of the vote"
          end
          post :votes do
            vote_result = Factories::VoteFactory.new.create(vote_attributes: params)

            if vote_result.errors.any?
              raise "Error!"
            end

            serialize_response(vote_result.response.reload)
          end
        end
      end

    end
  end
end