import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
import Comment from "./Comment"
import Thread from "./Thread"
import PostSummaryHelper from "./helper/PostSummaryHelper"
class ThreadContainer extends React.Component {  
  constructor(props) {
    super(props);

    this.state = {
      summary: {}
    }
  }
  
  componentDidMount() {
    this.getSummary().then((summary) => {
      this.setState({
        summary: summary
      });
    });
  }

  getSummary() {
    return PostSummaryHelper.get({ post_id: this.props.post.id["$oid"] });
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
          voteBody={ { post_id: postId } }
          summary={ this.state.summary }
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
