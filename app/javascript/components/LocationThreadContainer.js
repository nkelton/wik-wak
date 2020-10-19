import React from "react"
import PropTypes from "prop-types"
import PostForm from "./PostForm"
import ThreadContainer from "./ThreadContainer"
import Jumbotron from 'react-bootstrap/Jumbotron'
import Button from 'react-bootstrap/Button'
import Modal from 'react-bootstrap/Modal'
class LocationThreadContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      location: [],
      posts: [],
      comments: [],
      threads: [],
      show: false
    };

    this.handleClose = this.handleClose.bind(this);
    this.handleShow = this.handleShow.bind(this);
  }

  componentDidMount() {
    this.getClientPosition().then((position) => {
        let location = [position.coords.latitude, position.coords.longitude];
        this.setState({
          location: location
        });

        return location;
      }).then((location) => {
        return this.fetchPostsFrom(location);
      }).then((posts) => {
        this.setState({
          posts: posts
        });

        return Promise.all(posts.map((post) => {
          return this.fetchCommentsFor(post.id["$oid"]);
        }));
      }).then((comments) => {
        this.setState({
          comments: comments
        })
      }).then(() => {
        let threads = this.state.comments.map((comments, index) => {
          return {
            post: this.state.posts[index],
            comments: comments
          }
        });

        this.setState({
          threads: threads
        });
      })
  }

  getClientPosition(options) {
    return new Promise(function (resolve, reject) {
      navigator.geolocation.getCurrentPosition(resolve, reject, options);
    });
  }

  fetchPostsFrom(location) {
    const POSTS_URL = "http://localhost:3000/posts?"

    return fetch(POSTS_URL + new URLSearchParams({
      location: location
    }), {
      headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.props.authenticity_token
      }
    }).then(response => response.json())
  }

  fetchCommentsFor(postId) {
    const COMMENTS_URL = "http://localhost:3000/comments?"

    return fetch(COMMENTS_URL + new URLSearchParams({
      post_id: postId
    }), {
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.props.authenticity_token
      }
    }).then(response => response.json());
  }

  handleShow() {
    this.setState({
      show: true
    });
  }

  handleClose() {
    this.setState({
      show: false
    });
  }

  render () {
    let threads = this.state.threads.map(thread => {
      return (
        <ThreadContainer 
          post={ thread.post }
          comments={ thread.comments }
          authenticity_token={ this.props.authenticity_token }
          key={ thread.post.id["$oid"] } 
        />
      );
    }); 

    return (
      <React.Fragment>
        <div>
          <Jumbotron className="jumbotron vertical-center">
            <div className="container-fluid">
              <h1>WikWak</h1>
              <p>Like YikYak but with a 'W'</p>
              <Button 
                onClick={ this.handleShow }
                variant="success">
                Make Post
              </Button>
              <Modal
                show={ this.state.show }
                onHide={ this.handleClose }
                backdrop="static"
                keyboard={ false }
              >
                <Modal.Header closeButton>
                  <Modal.Title>Post</Modal.Title>
                </Modal.Header>
                <Modal.Body>
                  <PostForm
                    authenticity_token={ this.props.authenticity_token }
                  />
                </Modal.Body>
              </Modal>
            </div>
          </Jumbotron>
        </div>
        <div className="container">
          { threads }
        </div>
      </React.Fragment>
    );
  }
}

export default LocationThreadContainer
