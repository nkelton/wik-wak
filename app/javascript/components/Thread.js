import React from "react"
import PropTypes from "prop-types"
import CommentForm from "./CommentForm"
import Card from 'react-bootstrap/Card'
import ListGroup from 'react-bootstrap/ListGroup' 
import Nav from 'react-bootstrap/Nav'
import Accordion from 'react-bootstrap/Accordion'
import Button from 'react-bootstrap/Button'
import Vote from './Vote'
class Thread extends React.Component {
  render () {
    return (
      <React.Fragment>
        <Accordion>
          <Card>
            <ListGroup variant="flush">
              <ListGroup.Item>
                { this.props.parent }
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
                      <strong> { this.props.children.length } </strong> Comments
                    </Accordion.Toggle>
                  </Nav.Item>
                  <Nav.Item>
                    <Vote />
                  </Nav.Item>
                </Nav>
              </ListGroup.Item>
              <Accordion.Collapse eventKey="1">
                  <ListGroup.Item> 
                    { this.props.children } 
                  </ListGroup.Item>
                </Accordion.Collapse>
                <Accordion.Collapse eventKey="0">
                  <ListGroup.Item>  
                    <CommentForm
                      parentId= { this.props.parentId } 
                      postId={ this.props.postId }
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

export default Thread
