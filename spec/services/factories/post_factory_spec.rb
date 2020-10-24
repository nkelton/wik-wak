require 'rails_helper'

RSpec.describe "PostFactory" do

    subject { Factories::PostFactory.new } 

    let(:title) { "post" }
    let(:body) { "blah blah" }
    let(:ip) { "123.123.123" }
    let(:lat) { "32.454" }
    let(:lng) { "-1.5654" }
    let(:location) { [lat, lng] }

    context '#create' do 
        let(:post_params) do
            {
                title: title,
                body: body,
                ip: ip,
                location: location
            }
        end

        it 'creates post' do
            result = nil
            expect {
                result = subject.create(post: post_params)  
            }.to change { Post.count }.by(1)

            expect(result.code).to eq(Factories::PostFactory::SUCCESS)
        end
    end
end
