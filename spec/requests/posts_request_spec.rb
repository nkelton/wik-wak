require 'rails_helper'

RSpec.describe "Posts", type: :request do
    describe "POST posts#create" do

        let(:params) do 
            {
                post: {
                    title: "post!",
                    body: "blah blah",
                    ip: "123.123.123",
                    location: ["110.34", "-5.342"]
                }
            }
        end

        let(:headers) do 
            {
                "Content-Type": "applicaiton/json"
            }
        end
        
        context 'with valid attributes' do 
            it 'creates post and post_summary' do
                binding.pry 
                post '/posts', params: params, headers: headers
                json = JSON.parse(response.body)
                
                binding.pry 

                expect(response).to have_http_status(201)
            end
        end
    end
end
