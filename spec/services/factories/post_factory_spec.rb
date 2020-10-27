require 'rails_helper'

RSpec.describe "PostFactory" do
    subject { Factories::PostFactory.new } 

    let(:title) { "post" }
    let(:body) { "blah blah" }
    let(:ip) { "123.123.123" }
    let(:lat) { "32.454" }
    let(:lng) { "-1.5654" }
    let(:location) { [lat, lng] }

    #TODO - needed to set up collection before running transaction 
    let!(:post) { create(:post) }
    let!(:post_summary) { create(:post_summary, post_id: post.id) }

    let(:post_attributes) { attributes_for(:post) }

    context '#create' do 
        context 'with valid attributes' do    
            it 'creates post and post_summary' do
                result = nil
                expect {
                    result = subject.create(post_attributes: post_attributes)  
                }.to change { Post.count }.by(1)
    
                expect(result.code).to eq(Factories::PostFactory::SUCCESS)
            end
        end

        context "when post_summary factory raises error" do
            let(:factory_response) do 
                Factories::PostSummaryFactory::Result.new(
                    response: nil,
                    errors: ["Error!"],
                    code: Factories::PostSummaryFactory::ERROR
                )
            end

            before do
                expect_any_instance_of(Factories::PostSummaryFactory).to receive(:create).and_return(factory_response)
            end

            it 'no records are created' do
                result = nil
                expect {
                    result = subject.create(post_attributes: post_attributes)  
                }.to change { Post.count }.by(0)
                .and change { PostSummary.count }.by(0)
                    
                expect(result.code).to eq(Factories::PostFactory::ERROR)
            end
        end 

        context "when comment creation raises error" do
            before do
                allow(Post).to receive(:create!).and_raise(Mongo::Error.new("Error!"))
            end

            it 'no records are created' do
                result = nil
                expect {
                    result = subject.create(post_attributes: post_attributes)  
                }.to change { Post.count }.by(0)
                .and change { PostSummary.count }.by(0)
                
                expect(result.code).to eq(Factories::PostFactory::ERROR)
            end
        end 

    end
end
