require 'rails_helper'

RSpec.describe "API::V1::Comments", type: :request do
  let(:headers) do 
    {
        "Content-Type": "application/json"
    }
  end

  describe "POST comments#votes#create" do
    let!(:existing_post) { create(:post) }
    let(:post_id) { existing_post.id }

    let!(:comment) { create(:comment, post_id: post_id) }
    let(:comment_id) { comment.id }

    let!(:comment_summary) { create(:comment_summary, comment_id: comment_id) }    
    
    let(:params) do
      {
        ip: "123.123.123",
        value: Vote::UPVOTE
      }
    end 

    context "with valid attributes" do
      it 'creates vote for comment' do
        post "/api/v1/comments/#{comment_id}/votes", params: params.to_json, headers: headers
        json = JSON.parse(response.body)
        expect(response).to have_http_status(201)
      end
    end
  end


end
