import React from "react"
import PropTypes from "prop-types"
import Form from 'react-bootstrap/Form'
import Button from 'react-bootstrap/Button'
class PostForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: '',
      body: '',
      ip: '',
      location: []
    };

    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleBodyChange = this.handleBodyChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.setGeoCoordinates = this.setGeoCoordinates.bind(this);

    this.retrieveClientIP();
    navigator.geolocation.getCurrentPosition(this.setGeoCoordinates);
  }

  handleTitleChange(event) {
    this.setState({
      title: event.target.value
    });
  }

  handleBodyChange(event) {
    this.setState({
      body: event.target.value
    });
  }

  handleSubmit(event) {
    event.preventDefault();

    if(!this.validateForm()) {
      //TODO - show error
      return; 
    }

    const data = {
      title: this.state.title,
      body: this.state.body,
      ip: this.state.ip,
      location: this.state.location
    }

    const csrfToken = $('meta[name=csrf-token]').attr('content');
    const COMMENTS_URL = "http://localhost:3000/posts";

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
    if(this.state.title === '') {
      return false;    
    } else if(this.state.body === '') {
      return false;
    } else if(this.state.ip === '') {
      return false;
    } else if(this.state.location.length == 0) {
      return false; 
    }

    return true;
  }

  retrieveClientIP() {
    const url = "https://api.ipify.org/?format=json"
    return fetch(url)
      .then(response => response.json())
      .then(data => this.setState({ ip: data.ip }))
  }

  setGeoCoordinates(position) {
    this.setState({
      location: [position.coords.latitude, position.coords.longitude]
    });
  }

  render () {
    return (
      <div>
        <Form
          onSubmit={ this.handleSubmit }
        >
          <Form.Group 
            controlId="postTitle"
          >
            <Form.Label>Title</Form.Label>
            <Form.Control 
              type="string" 
              placeholder="Enter title" 
              value={ this.state.title }
              onChange={ this.handleTitleChange } 
            />
          </Form.Group>
          <Form.Group 
            controlId="postBody"
          >
            <Form.Label>Body</Form.Label>
            <Form.Control 
              as="textarea" 
              rows="3"
              value={ this.state.body }
              onChange={ this.handleBodyChange } 
            />
          </Form.Group>
          <Button 
            variant="primary" 
            type="submit"
          >
            Make Post
          </Button>
        </Form>
      </div>
    );
  }
}

PostForm.propTypes = {
  title: PropTypes.string,
  body: PropTypes.node,
  authenticity_token: PropTypes.string
};
export default PostForm
