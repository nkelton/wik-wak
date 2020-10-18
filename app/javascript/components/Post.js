import React from "react"
import PropTypes from "prop-types"
class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        Title: {this.props.post.title}
        Body: {this.props.post.body}
      </React.Fragment>
    );
  }
}

Post.propTypes = {
  title: PropTypes.string,
  body: PropTypes.node
};
export default Post
