import React from "react"
import PropTypes from "prop-types"
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
      post_id: this.props.post_id
    }

    const COMMENTS_URL = "http://localhost:3000/comments"

    fetch(COMMENTS_URL, {
      method: 'POST',
      headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.props.authenticity_token
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
      <form onSubmit={ this.handleSubmit }>
        <label>
          Name:
          <input type="text" value={ this.state.name } onChange={ this.handleNameChange } />
        </label>
        <label>
          Message: 
          <textarea value={ this.state.message } onChange={ this.handleMessageChange } />
        </label>
        <input type="submit" value="Submit" />
      </form>
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
