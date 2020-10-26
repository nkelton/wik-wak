require 'rails_helper'

RSpec.describe "API::V1::Posts", type: :request do
    let(:headers) do 
        {
            "Content-Type": "application/json"
        }
    end
    describe "POST posts#create" do

        let(:params) do 
            {
                title: "post!",
                body: "blah blah",
                ip: "123.123.123",
                location: ["110.34", "-5.342"]
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

    describe "GET posts#get" do
        let(:post) { create(:post, location: [lat, lng] ) }
        let(:post_summary) { create(:post_summary, post_id: post.id) }

        let(:lat) { "23.45" }
        let(:lng) { "45.65" }
        let(:offset) { 0 }
        let(:limit) { 1 }

        let(:params) do
            {
                lat: lat,
                lng: lng,
                offset: offset,
                limit: limit
            }
        end

        before do
            post 
            post_summary
        end

        context 'with valid params' do
            it 'returns posts' do 
                get "/api/v1/posts", params: params, headers: headers 
                json = JSON.parse(response.body)
                expect(response).to have_http_status(200)
            end 
        end 
    end
            
end
