import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
import Comment from "./Comment"
import CommentForm from "./CommentForm"
import Card from 'react-bootstrap/Card'
import ListGroup from 'react-bootstrap/ListGroup' 
import Nav from 'react-bootstrap/Nav'
import Accordion from 'react-bootstrap/Accordion'
import Button from 'react-bootstrap/Button'
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
        <Accordion>
          <Card>
            <ListGroup 
              variant="flush">
                <ListGroup.Item>
                  <h2>Post</h2>
                  <Post
                    post={ this.props.post }>
                  </Post>
                </ListGroup.Item>
                <ListGroup.Item>
                  <Nav as="ul">
                    <Nav.Item as="li">
                      <Accordion.Toggle as={ Button } variant="link" eventKey="0">
                        Reply
                      </Accordion.Toggle>                    
                    </Nav.Item>
                    <Nav.Item as="li">
                      <Accordion.Toggle as={ Button } variant="link" eventKey="1">
                        <strong> { commentCount } </strong> Comments
                      </Accordion.Toggle>
                    </Nav.Item>
                  </Nav>
                </ListGroup.Item>
                <Accordion.Collapse eventKey="1">
                  <ListGroup.Item> 
                    { comments } 
                  </ListGroup.Item>
                </Accordion.Collapse>
                <Accordion.Collapse eventKey="0">
                  <ListGroup.Item> 
                    <CommentForm 
                      post_id={ this.props.post ? this.props.post.id["$oid"] : null }
                      authenticity_token={ this.props.authenticity_token }
                    /> 
                  </ListGroup.Item>
                </Accordion.Collapse>
            </ListGroup>
          </Card>
        </Accordion>
      </React.Fragment>
    );
  }
}

ThreadContainer.propTypes = {
  post: PropTypes.object,
  comments: PropTypes.array
};
export default ThreadContainer
