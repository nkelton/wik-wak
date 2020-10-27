require 'rails_helper'

RSpec.describe "CommnetFactory" do

    subject { Factories::CommentFactory.new } 
    
    let(:existing_post) { create(:post) }
    let(:post_id) { existing_post.id }

    let(:comment_attributes)  { attributes_for(:comment ,post_id: post_id) }

    #TODO - needed to set up collection before running transaction 
    let!(:comment) { create(:comment, post_id: post_id) }
    let!(:comment_summary) { create(:comment_summary, comment_id: comment.id) }

    context '#create' do 
        context "with valid attributes" do
            it 'creates comment' do
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

        context "when comment_summary factory raises " do
            let(:factory_response) do 
                Factories::CommentSummaryFactory::Result.new(
                    response: nil,
                    errors: ["Error!"],
                    code: Factories::CommentSummaryFactory::ERROR
                )
            end

            before do
                expect_any_instance_of(Factories::CommentSummaryFactory).to receive(:create).and_return(factory_response)
            end

            it 'no records are created' do
                result = nil
                expect {
                    result = subject.create(comment_attributes: comment_attributes)  
                }.to change { Comment.count }.by(0)
                .and change { CommentSummary.count }.by(0)
                    
                expect(result.code).to eq(Factories::CommentFactory::ERROR)
            end
        end 

        context "when comment creation raises " do
            before do
                allow(Comment).to receive(:create!).and_raise(Mongo::Error.new("Error!"))
            end

            it 'no records are created' do
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
