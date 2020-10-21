import React from "react"
import PropTypes from "prop-types"
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button'
class CommentForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = { 
      name: '', 
      message: '',
    };

    this.handleNameChange = this.handleNameChange.bind(this);
    this.handleMessageChange = this.handleMessageChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleNameChange(event) {
    this.setState({
      name: event.target.value
    });
  }

  handleMessageChange(event) {
    this.setState({
      message: event.target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();

    if(!this.validateForm()) {
      //TODO - show error
      return; 
    }

    const data = {
      name: this.state.name,
      message: this.state.message,
      post_id: this.props.postId,
      parent_id: this.props.parentId
    };

    const csrfToken = $('meta[name=csrf-token]').attr('content');
    const COMMENTS_URL = "http://localhost:3000/comments";

    fetch(COMMENTS_URL, {
      method: 'POST',
      headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify(data)
    }).then(response => window.location.reload())
  }

  validateForm() {
    if(this.state.name === '') {
      return false;    
    } else if(this.state.message === '') {
      return false;
    }

    return true;
  }

  render () {
    return (
      <div>
        <Form 
          onSubmit={ this.handleSubmit } >
          <Form.Group 
            controlId="commentName"
          >
            <Form.Label>Name</Form.Label>
            <Form.Control 
              type="string" 
              placeholder="Enter name" 
              value={ this.state.name }
              onChange={ this.handleNameChange } 
            />
          </Form.Group>
          <Form.Group 
            controlId="commentMessage"
          >
            <Form.Label>Message</Form.Label>
            <Form.Control 
              as="textarea" 
              rows="3"
              value={ this.state.message }
              onChange={ this.handleMessageChange } 
            />
          </Form.Group>
          <Button 
            variant="primary" 
            type="submit"
          >
            Add Comment
          </Button>
        </Form>
      </div>
    );
  }
}

CommentForm.propTypes = {
  name: PropTypes.string,
  message: PropTypes.node,
  post_id: PropTypes.string,
  authenticity_token: PropTypes.string
};
export default CommentForm
