import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
import Comment from "./Comment"
import Thread from "./Thread"
class ThreadContainer extends React.Component {  
  post() {
    return(
      <Post
        post={ this.props.post }>
      </Post>
    )
  }

  parentComments() {
    return this.props.comments.filter(c => c.parent_id === null)
  }

  render () {
    let comments = this.props.comments.map((comment) => {
      return(
        <Comment 
          comment={ comment }
          comments={ this.props.comments }
          key={ comment.id["$oid"] }
        />
      )
    });

    return (
      <React.Fragment>
        <Thread
          parent={ this.post() }
          children={ comments }
          postId={ this.props.post.id["$oid"] }
          parentId={ null }
        />
      </React.Fragment>
    );
  }
}

ThreadContainer.propTypes = {
  post: PropTypes.object,
  comments: PropTypes.array
};
export default ThreadContainer
