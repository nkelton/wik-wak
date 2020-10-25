require 'rails_helper'

RSpec.describe "API::V1::Posts", type: :request do
    describe "POST posts#create" do

        let(:params) do 
            {
                title: "post!",
                body: "blah blah",
                ip: "123.123.123",
                location: ["110.34", "-5.342"]
            }
        end

        let(:headers) do 
            {
                "Content-Type": "application/json"
            }
        end
        
        context 'with valid attributes' do 
            it 'creates post' do
                post '/api/v1/posts', params: params.to_json, headers: headers
                json = JSON.parse(response.body)
                expect(response).to have_http_status(201)
            end
        end
    end
end
