import React from "react"
import PropTypes from "prop-types"
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div>
          Name: {this.props.comment.name}
          Message: {this.props.comment.message}
        </div>
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  name: PropTypes.string,
  message: PropTypes.node
};
export default Comment
