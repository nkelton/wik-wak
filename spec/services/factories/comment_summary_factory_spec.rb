require 'rails_helper'

RSpec.describe "CommentSummaryFactory" do
    subject { Factories::CommentSummaryFactory.new } 

    let(:post) { create(:post) } 
    let(:comment) { create(:comment, post_id: post.id) }
    let(:comment_id) { comment.id }

    context "#create" do
        context 'with valid comment_id' do         
            it 'creates comment summary' do
                result = nil
                expect {
                    result = subject.create(comment_id: comment_id) 
                }.to change { CommentSummary.count }.by(1)

                expect(result.code).to equal(Factories::CommentSummaryFactory::SUCCESS) 
            end
        end
    end

    context "#up_vote" do
        let(:comment_summary) { create(:comment_summary, comment_id: comment_id) }

        context 'with valid comment_id' do
            it 'increaes comment_summary up_vote by 1' do
                result = nil
                expect {
                    result = subject.up_vote(comment_id: comment_id)
                }.to change { comment_summary.reload.up_votes }.by(1)            
    
                expect(result.code).to equal(Factories::CommentSummaryFactory::SUCCESS) 
            end
        end

        context 'with invalid comment_id' do 
            let(:invalid_comment_id) { "invalid_comment_id" }
            
            it 'returns error' do
                result = nil
                expect {
                    result = subject.up_vote(comment_id: invalid_comment_id) 
                }.to change { comment_summary.reload.up_votes }.by(0) 
                
                expect(result.code).to equal(Factories::CommentSummaryFactory::ERROR)  
            end
        end
    end

    context "#down_vote" do
        let(:comment_summary) { create(:comment_summary, comment_id: comment_id) }

        context 'with valid comment_id' do
            it 'increaes comment_summary down_vote by 1' do
                result = nil
                expect {
                    result = subject.down_vote(comment_id: comment_id)
                }.to change { comment_summary.reload.down_votes }.by(1)            
    
                expect(result.code).to equal(Factories::CommentSummaryFactory::SUCCESS) 
            end
        end
        
        context 'with invalid invalid_comment_id' do 
            let(:invalid_comment_id) { "invalid_post_id" }
            
            it 'returns error' do
                result = nil
                expect {
                    result = subject.down_vote(comment_id: invalid_comment_id) 
                }.to change { comment_summary.reload.down_votes }.by(0) 
                
                expect(result.code).to equal(Factories::CommentSummaryFactory::ERROR)  
            end
        end
    end

    context '#increment_comment_count' do 
        let(:comment_summary) { create(:comment_summary, comment_id: comment_id) }

        context 'with valid comment_id' do 
            it 'increments comment count by 1' do
                result = nil
                expect {
                    result = subject.increment_comment_count(comment_id: comment_id) 
                }.to change { comment_summary.reload.comment_count }.by(1)
            
                expect(result.code).to equal(Factories::CommentSummaryFactory::SUCCESS)
            end
        end

        context 'with invalid comment_id' do
            it 'returns error' do
                result = nil
                expect {
                    result = subject.increment_comment_count(comment_id: "bad_comment_id") 
                }.to change { comment_summary.reload.comment_count }.by(0)

                expect(result.code).to equal(Factories::CommentSummaryFactory::ERROR)
            end
        end
    end

end