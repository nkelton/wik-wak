import React from "react"
import PropTypes from "prop-types"
class CommentForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = { 
      name: '', 
      message: '',
      postId: props.post_id,
      authenticityToken: props.authenticity_token 
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

    const data = {
      name: this.state.name,
      message: this.state.message,
      post_id: this.state.postId
    }

    const COMMENTS_URL = "http://localhost:3000/comments"

    fetch(COMMENTS_URL, {
      method: 'POST',
      headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.state.authenticityToken
      },
      body: JSON.stringify(data)
    })
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
  postId: PropTypes.string
};
export default CommentForm
