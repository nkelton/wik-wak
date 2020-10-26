import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
import Comment from "./Comment"
import Thread from "./Thread"
import PostSummaryHelper from "./helper/PostSummaryHelper"
class ThreadContainer extends React.Component {  
  constructor(props) {
    super(props);
  }

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
    let comments = this.parentComments().map((comment) => {
      return(
        <Comment 
          comment={ comment }
          comments={ this.props.comments }
          key={ comment.id["$oid"] }
        />
      )
    });

    let postId =  this.props.post.id["$oid"]

    return (
      <React.Fragment>
        <Thread
          parent={ this.post() }
          children={ comments }
          postId={ postId }
          parentId={ null }
          parentLinks={ this.props.post.links }
          summary={ this.props.post.summary }
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
