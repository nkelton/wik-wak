require 'rails_helper'

RSpec.describe "VoteFactory" do
    subject { Factories::VoteFactory.new }

    context "#create" do
        context 'with valid attributes' do            
            context 'post' do
                let!(:post) { create(:post) }
                let(:vote_attributes) { attributes_for(:vote, post_id: post.id) }

                before do 
                    expect(PostSummaryVoteWorker).to receive(:perform_async) 
                end 

                it 'creates a vote' do 
                    result = nil
                    expect {
                        result = subject.create(vote_attributes: vote_attributes)                
                    }.to change { Vote.count }.by(1)
                
                    vote = result.response 
                    expect(vote.post_id).to eq(post.id)

                    expect(result.code).to eq(Factories::VoteFactory::SUCCESS)
                end
            end

            context 'comment' do 
                let!(:post) { create(:post) }
                let!(:comment) { create(:comment, post_id: post.id) }

                let(:vote_attributes) { attributes_for(:vote, comment_id: comment.id) }
         
                before do 
                    expect(CommentSummaryVoteWorker).to receive(:perform_async) 
                end 

                it 'creates a vote' do 
                    result = nil
                    expect {
                        result = subject.create(vote_attributes: vote_attributes)                
                    }.to change { Vote.count }.by(1)
                
                    expect(result.code).to eq(Factories::VoteFactory::SUCCESS)
                end 
            end
        end 
    end
end