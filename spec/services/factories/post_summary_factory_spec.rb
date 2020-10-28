require 'rails_helper'

RSpec.describe "PostSummaryFactory" do
    subject { Factories::PostSummaryFactory.new } 

    context "#create" do
        #TODO - intiailize database collections
        let!(:existing_post) { create(:post) } 
        let!(:existing_post_summary) { create(:post_summary, post_id: existing_post.id) }

        context 'with valid attributes' do 
            let(:post) { create(:post) }
            let(:post_id) { post.id }
        
            it 'creates post summary' do
                result = nil
                expect {
                    result = subject.create(post_id: post_id) 
                }.to change { PostSummary.count }.by(1)

                expect(result.code).to equal(Factories::PostSummaryFactory::SUCCESS) 
            end
        end
    end

    context "#up_vote" do
        let!(:post) { create(:post) }
        let!(:post_summary) { create(:post_summary, post_id: post.id) }

        context 'with valid post_id' do
            it 'increaes post_summary up_vote by 1' do
                result = nil
                expect {
                    result = subject.up_vote(post_id: post.id)
                }.to change { post_summary.reload.up_votes }.by(1)            
    
                expect(result.code).to equal(Factories::PostSummaryFactory::SUCCESS) 
            end
        end

        context 'with invalid post_id' do 
            let(:invalid_post_summary_id) { "invalid_post_id" }
            
            it 'returns error' do
                result = nil
                expect {
                    result = subject.up_vote(post_id: invalid_post_summary_id) 
                }.to change { post_summary.reload.up_votes }.by(0) 
                
                expect(result.code).to equal(Factories::PostSummaryFactory::ERROR)  
            end
        end
    end

    context "#down_vote" do
        let!(:post) { create(:post) }
        let!(:post_summary) { create(:post_summary, post_id: post.id) }
                 
        context 'with valid post_id' do
            it 'increaes post_summary down_vote by 1' do
                result = nil
                expect {
                    result = subject.down_vote(post_id: post.id)
                }.to change { post_summary.reload.down_votes }.by(1)            
    
                expect(result.code).to equal(Factories::PostSummaryFactory::SUCCESS) 
            end
        end

        context 'with invalid post_id' do 
            let(:invalid_post_summary_id) { "invalid_post_id" }
            
            it 'returns error' do
                result = nil
                expect {
                    result = subject.down_vote(post_id: invalid_post_summary_id) 
                }.to change { post_summary.reload.down_votes }.by(0) 
                
                expect(result.code).to equal(Factories::PostSummaryFactory::ERROR)  
            end
        end
    end
end