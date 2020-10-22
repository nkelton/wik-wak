import React from "react"
import PropTypes from "prop-types"
import Card from 'react-bootstrap/Card'
import Thread from './Thread'
class Comment extends React.Component {

  isChild(childParentId) {
    return childParentId === this.props.comment.id["$oid"]
  }

  replies() {
    return this.props.comments.filter(c => c.parent_id ? this.isChild(c.parent_id["$oid"]) : false)
  }

  comment() {
    return(
      <Card>
        <Card.Header><h6>{ this.props.comment.name }</h6></Card.Header>
        <Card.Body>
          <Card.Text>{ this.props.comment.message }</Card.Text>
        </Card.Body>
      </Card>
    )
  }

  render () {
    let replies = this.replies().map(reply => (
      <Comment
        comment={ reply }
        comments={ this.props.comments }
        key={ reply.id["$oid"] }
      />
    ))

    return (
      <React.Fragment>
        <Thread
          parent={ this.comment() }
          children={ replies }
          parentId={ this.props.comment.id["$oid"] }
          postId={ this.props.comment.post_id["$oid"] }
          voteBody={ { comment_id: this.props.comment.id["$oid"] } }
        />
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  name: PropTypes.string,
  message: PropTypes.node
};
export default Comment
