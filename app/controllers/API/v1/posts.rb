module API
    module V1
      class Posts < Grape::API
        include API::V1::Defaults
  
        resource :posts do
          desc "Return queried posts"
          params do
            requires :lat, type: String, desc: "Latitude of the post"
            requires :lng, type: String, desc: "Longitude of the post"
            requires :offset, type: Integer, desc: "Offset of the posts"
            requires :limit, type: Integer, desc: "Limit of the posts"
          end
          get "", root: :posts do
            location_param = [params[:lat], params[:lng]].map { |coord| coord&.to_f }
            posts = Post.near_sphere(location: location_param)
                        .paginate(offset: params[:offset], limit: params[:limit])
                        .desc(:_id)
                        .map{ |post| post }

            serialize_response(posts)
          end
  
          desc "Create a post"
          params do
            requires :title, type: String, desc: "Title of the post"
            requires :body, type: String, desc: "Body of the post"
            requires :ip, type: String, desc: "Ip address of the post"
            requires :location, type: Array, desc: "Location of the post [lat, lng]"
          end
          post "", root: :posts do
              post_result = Factories::PostFactory.new.create(post: params)
              if post_result.code == Factories::PostFactory::SUCCESS
                post_summary_result = Factories::PostSummaryFactory.new.create(post_id: post_result.response.id)
              end
              
              if post_result.errors.any? || post_summary_result.errors.any?
                #TODO - better error handling
                raise "Error!"
              end

              serialize_response(post_result.response)
          end
        end
      end
    end
end
    