namespace :bootstrap do

    desc "Create default post to initialze db"
    task :default_post => :environment do
        post = Post.create(title: 'default', body: 'blah', ip: "123.123.123", location: ["1.23", "4.56"])
        PostSummary.create(post_id: post.id)
    
        Post.create_indexes
        PostSummary.create_indexes
    end

    desc "Create default comment to intialize db"
    task :default_comment => :environment do
        comment = Comment.create(name: "defualt", message: "default", post_id: Post.all.first.id)
        CommentSummary.create(comment_id: comment.id)
    
        Comment.create_indexes
        CommentSummary.create_indexes
    end 

    desc "Create default vote to intialize db"
    task :default_vote => :environment do
        Vote.create!(post_id: Post.all.first.id, value: 1)

        Vote.create_indexes
    end 


    desc "Run all bootstrapping tasks"
    task :all => [:default_post, :default_comment, :default_vote]
end