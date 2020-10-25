module API
    module V1
      class Posts < Grape::API
        include API::V1::Defaults
  
        resource :posts do
          desc "Return all posts"
          get "", root: :posts do
            Post.all
          end
  
          desc "Return a post"
          params do
            requires :id, type: String, desc: "ID of the post"
          end
          get ":id", root: "post" do
            Post.where(id: permitted_params[:id]).first!
          end

          desc "Create a post"
          params do
            requires :title, type: String, desc: "Title of the post"
            requires :body, type: String, desc: "Body of the post"
            requires :ip, type: String, desc: "Ip address of the post"
            requires :location, type: Array, desc: "Location of the post [lat, lng]"
          end
          post "", root: :posts do
              result = Factories::PostFactory.new.create(post: params)
              
              if result.errors.any?
                raise "Error!"
              end

              { 
                post: result.response 
              }
          end
        end
      end
    end
end
    