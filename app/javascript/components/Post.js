import React from "react"
import PropTypes from "prop-types"
import Card from 'react-bootstrap/Card'
class Post extends React.Component {
  render () {
    return (
      <React.Fragment>
        <Card 
          border="primary"
        >
          <Card.Header><h4>{ this.props.post.title }</h4></Card.Header>
          <Card.Body>
            <Card.Text>{ this.props.post.body }</Card.Text>
          </Card.Body>
        </Card>
      </React.Fragment>
    );
  }
}

Post.propTypes = {
  title: PropTypes.string,
  body: PropTypes.node
};
export default Post
