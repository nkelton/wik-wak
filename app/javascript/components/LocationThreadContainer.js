import React from "react"
import PropTypes from "prop-types"
import PostForm from "./PostForm"
import ThreadContainer from "./ThreadContainer"
import Jumbotron from 'react-bootstrap/Jumbotron'
import Button from 'react-bootstrap/Button'
import Modal from 'react-bootstrap/Modal'
import InfiniteScroll from 'react-infinite-scroller';
class LocationThreadContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      location: [],
      posts: [],
      comments: [],
      threads: [],
      show: false,
      hasMore: true,
      postOffset: 0,
      postLimit: 3,
    };

    this.handleClose = this.handleClose.bind(this);
    this.handleShow = this.handleShow.bind(this);
  }

  componentDidMount() {
    this.getClientPosition().then((position) => {
        this.setState({
          location: [position.coords.latitude, position.coords.longitude]
        });
      }).then(() => {
        return this.fetchThreads();
      });
  }

  getClientPosition(options) {
    return new Promise(function (resolve, reject) {
      navigator.geolocation.getCurrentPosition(resolve, reject, options);
    });
  }

  fetchPostsFrom() {
    const POSTS_URL = "http://localhost:3000/posts?"

    return fetch(POSTS_URL + new URLSearchParams({
      location: this.state.location,
      offset: this.state.postOffset,
      limit: this.state.postLimit
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

  fetchThreads() {
    return this.fetchPostsFrom().then((posts) => {
      let offSet = posts.length;

      if(offSet < this.state.postLimit) {
        this.setState({
          hasMore: false
        });
      }

      this.setState({
        posts: this.state.posts.concat(posts),
        postOffset: this.state.postOffset + offSet
      });

      return Promise.all(posts.map((post) => {
        return this.fetchCommentsFor(post.id["$oid"]);
      }));
    }).then((comments) => {
      this.setState({
        comments: this.state.comments.concat(comments)
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
          authenticity_token={ this.props.authenticity_token } //can probably remove this? it's already in props
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
          <InfiniteScroll
          initialLoad={ false }
            hasMore={ this.state.hasMore }
            loadMore= { this.fetchThreads.bind(this) }
            loader={<div className="loader" key={0}>Loading ...</div>}
          >
            <div className="threads">
              { threads }
            </div>
          </InfiniteScroll>
        </div>
      </React.Fragment>
    );
  }
}

export default LocationThreadContainer
