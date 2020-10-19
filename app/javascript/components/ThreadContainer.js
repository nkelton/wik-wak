import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
import Comment from "./Comment"
import CommentForm from "./CommentForm"
class ThreadContainer extends React.Component {
  render () {
    var commentCount = this.props.comments.length;
    var comments = this.props.comments.map((comment) => {
      return(
        <Comment 
          comment={ comment }
          key={ comment.id["$oid"] }
        />
      )
    });

    return (
      <React.Fragment>
        <section className="section post">
          <div className="container">
            <Post 
              post={ this.props.post }
            />
          </div>
        </section>
        <section className="section comments">
          <div className="container">
            <h2 className="subtitle is-5">
              <strong> { commentCount } </strong> Comments
            </h2>
            { comments }
          </div>
        </section>
        <section className="section comment form">
          <div className="container">
            <CommentForm 
              post_id={ this.props.post ? this.props.post.id["$oid"] : null }
              authenticity_token={ this.props.authenticity_token }
            /> 
          </div>
        </section>
      </React.Fragment>
    );
  }
}

ThreadContainer.propTypes = {
  post: PropTypes.object,
  comments: PropTypes.array
};
export default ThreadContainer
