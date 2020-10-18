import React from "react"
import PropTypes from "prop-types"
class PostForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      title: '',
      body: '',
    };

    this.handleTitleChange = this.handleTitleChange.bind(this);
    this.handleBodyChange = this.handleBodyChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
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
    }

    const COMMENTS_URL = "http://localhost:3000/posts"

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
    if(this.state.title === '') {
      return false;    
    } else if(this.state.body === '') {
      return false;
    }

    return true;
  }

  render () {
    return (
      <form onSubmit={ this.handleSubmit }>
        <label>
          Title:
          <input type="text" value={ this.state.title } onChange={ this.handleTitleChange } />
        </label>
        <label>
          Body: 
          <textarea value={ this.state.body } onChange={ this.handleBodyChange } />
        </label>
        <input type="submit" value="Submit" />
      </form>
    );
  }
}

PostForm.propTypes = {
  title: PropTypes.string,
  body: PropTypes.node,
  authenticity_token: PropTypes.string
};
export default PostForm
