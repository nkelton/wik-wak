import React from "react"
import PropTypes from "prop-types"
import Post from "./Post"
class NearbyPostsContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      location: [],
      posts: []
    };

    // this.fetchNearbyPosts = this.fetchNearbyPosts(this);

    navigator.geolocation.getCurrentPosition((position) => {
      this.setState({
        location: [position.coords.latitude, position.coords.longitude]
      });

      this.fetchNearbyPosts();
    });
  }

  fetchNearbyPosts() {
    const POSTS_URL = "http://localhost:3000/posts?"

    fetch(POSTS_URL + new URLSearchParams({
      location: this.state.location
    }), {
      headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.props.authenticity_token
      }
    }).then(response => response.json())
      .then(posts => {
        this.setState({
          posts: posts
        });
      });
  }

  render () {
    var posts = this.state.posts.map((post) => {
      return (
        <Post 
          post={ post }
          key={ post.id["$oid"] } 
        />
      );
    }); 

    return (
      <React.Fragment>
        <div>
          { posts }
        </div>
      </React.Fragment>
    );
  }
}

export default NearbyPostsContainer
