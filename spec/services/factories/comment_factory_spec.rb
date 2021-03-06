require 'rails_helper'

RSpec.describe "CommentFactory" do

    subject { Factories::CommentFactory.new } 
    
    let(:existing_post) { create(:post) }
    let(:post_id) { existing_post.id }

    let(:comment_attributes)  { attributes_for(:comment ,post_id: post_id) }

    #TODO - needed to set up collection before running transaction 
    let!(:comment) { create(:comment, post_id: post_id) }
    let!(:comment_summary) { create(:comment_summary, comment_id: comment.id) }

    context '#create' do 
        context "with valid attributes" do

            before do 
                expect(IncrementCommentCountWorker).to receive(:perform_async) 
            end 

            it 'creates comment and comment_summary and queues count worker' do
                result = nil
                expect {
                    result = subject.create(comment_attributes: comment_attributes)  
                }.to change { Comment.count }.by(1)
                .and change { CommentSummary.count }.by(1)
    
                comment = result.response
                expect(comment.post_id).to eq(post_id)
    
                expect(result.code).to eq(Factories::CommentFactory::SUCCESS)
            end 
        end

        context "when comment_summary factory raises error" do
            let(:factory_response) do 
                Factories::PostSummaryFactory::Result.new(
                    response: nil,
                    errors: ["Error!"],
                    code: Factories::PostSummaryFactory::ERROR
                )
            end

            before do
                expect_any_instance_of(Factories::CommentSummaryFactory).to receive(:create).and_return(factory_response)
                expect(IncrementCommentCountWorker).to receive(:perform_async).never 
            end

            it 'no records are created and work is not queued' do
                result = nil
                expect {
                    result = subject.create(comment_attributes: comment_attributes)  
                }.to change { Comment.count }.by(0)
                .and change { CommentSummary.count }.by(0)
                    
                expect(result.code).to eq(Factories::CommentFactory::ERROR)
            end
        end 

        context "when comment creation raises error" do
            before do
                allow(Comment).to receive(:create!).and_raise(Mongo::Error.new("Error!"))
                expect(IncrementCommentCountWorker).to receive(:perform_async).never 
            end

            it 'no records are created and work is not queued' do
                result = nil
                expect {
                    result = subject.create(comment_attributes: comment_attributes)
                }.to change { Comment.count }.by(0)
                .and change { CommentSummary.count }.by(0)
                
                expect(result.code).to eq(Factories::CommentFactory::ERROR)
            end
        end 



    end
end
