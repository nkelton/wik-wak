import React from "react"
import PropTypes from "prop-types"
import Card from 'react-bootstrap/Card'
class Comment extends React.Component {
  render () {
    return (
      <React.Fragment>
        <Card 
          border="secondary"
        >
          <Card.Header><h6>{ this.props.comment.name }</h6></Card.Header>
          <Card.Body>
            <Card.Text>{ this.props.comment.message }</Card.Text>
          </Card.Body>
        </Card>
      </React.Fragment>
    );
  }
}

Comment.propTypes = {
  name: PropTypes.string,
  message: PropTypes.node
};
export default Comment
