import React from "react"
import PropTypes from "prop-types"
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        Name: {this.props.name}
        Message: {this.props.message}
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  name: PropTypes.string,
  message: PropTypes.node
};
export default Comment
