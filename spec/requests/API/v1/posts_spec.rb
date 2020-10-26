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
        let!(:post) { create(:post, location: [lat, lng] ) }
        let!(:post_summary) { create(:post_summary, post_id: post.id) }

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

        context 'with valid params' do
            it 'returns posts' do 
                get "/api/v1/posts", params: params, headers: headers 
                json = JSON.parse(response.body)
                expect(json.count).to eq(1)
                expect(response).to have_http_status(200)
            end 
        end 
    end

    describe "GET posts#comments#get" do
        let!(:post) { create(:post) }
        let(:post_id) { post.id }

        let!(:post_summary) { create(:post_summary, post_id: post_id) }

        let!(:comment) { create(:comment, post_id: post_id) }
        let(:comment_id) { comment.id }

        let!(:comment_summary) { create(:comment_summary, comment_id: comment_id) }

        context 'with valid post_id' do
            it 'returns all comments for post' do 
                get "/api/v1/posts/#{post_id}/comments", headers: headers 
                json = JSON.parse(response.body)
                expect(json.count).to eq(1)
                expect(response).to have_http_status(200)
            end 
        end 
    end

    describe "POST posts#comments#post" do
        let!(:existing_post) { create(:post) }
        let(:post_id) { existing_post.id }

        let!(:post_summary) { create(:post_summary, post_id: post_id) }

        let(:params) do 
            {
                name: "testing name",
                message: "testing message"
            }
        end
        
        context 'with valid attributes' do
            it 'creates a comment for post' do 
                post "/api/v1/posts/#{post_id}/comments", params: params.to_json, headers: headers 
                json = JSON.parse(response.body)
                expect(response).to have_http_status(201)
            end 
        end 
    end

    describe "POST posts#votes#post" do
        let!(:existing_post) { create(:post) }
        let(:post_id) { existing_post.id }

        let!(:post_summary) { create(:post_summary, post_id: post_id) }

        let(:params) do 
            {
                ip: "123.123.123",
                value: 1
            }
        end
        
        context 'with valid attributes' do
            it 'creates a comment for post' do 
                post "/api/v1/posts/#{post_id}/votes", params: params.to_json, headers: headers 
                json = JSON.parse(response.body)
                expect(response).to have_http_status(201)
            end 
        end 
    end
            
end
