import React from "react"
import PropTypes from "prop-types"
import PostForm from "./PostForm"
import ThreadContainer from "./ThreadContainer"
import Jumbotron from 'react-bootstrap/Jumbotron'
import Button from 'react-bootstrap/Button'
import Modal from 'react-bootstrap/Modal'
import InfiniteScroll from 'react-infinite-scroller';
import Spinner from 'react-bootstrap/Spinner'
import withFetchClientLocationDetails from './withFetchClientLocationDetails'
import withFetchPosts from './withFetchPosts'
import withFetchComments from './withFetchComments'
import equal from 'fast-deep-equal'
class LocationThreadContainer extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      threads: [],
      show: false,
    };

    this.handleClose = this.handleClose.bind(this);
    this.handleShow = this.handleShow.bind(this);
    this.fetchThreads = this.fetchThreads.bind(this);
  }

  componentDidUpdate(prevProps){
    this.didClientLocationDetailsFetch(prevProps) ? this.fetchThreads() : null
  }

  didClientLocationDetailsFetch(prevProps) {
    const {
      clientLocationDetails
    }= this.props;

    const newState = !equal(prevProps.clientLocationDetails, clientLocationDetails);
    const defaultState = prevProps.lat !== '' || prevProps.lng !== '' || !equals(prevProps.address, {}) || prevProps.ipAddress !== '';

    return newState && defaultState && !clientLocationDetails.loading
  }

  fetchThreads() {
    this.props.fetchPosts().then((posts) => {
      return this.props.fetchComments(posts);
    }).then(() => {
      const {
        fetchedPosts,
        fetchedComments
      }= this.props
  
      const threads = fetchedComments.results.map((comments, index) => {
        return {
          post: fetchedPosts.results[index],
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

  loader() {
    return(
      <Spinner animation="border" role="status" key={0}>
        <span className="sr-only">Loading...</span>
      </Spinner>
    );
  }

  render () {      
    const {
      address,
      ipAddress
    }= this.props.clientLocationDetails

    let threads = this.state.threads.map(thread => {
      return (
        <ThreadContainer 
          post={ thread.post }
          comments={ thread.comments }
          key={ thread.post.id["$oid"] } 
        />
      );
    });

    return (
      <React.Fragment>
        <div>
          <Jumbotron className="jumbotron vertical-center">
            <div className="container-fluid">
              <div className="row">
                <div className="col-xs-6">
                  <h1>WikWak</h1>
                  <p>Like YikYak but with a <strong>W</strong></p>
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
                      <PostForm/>
                    </Modal.Body>
                  </Modal>
                </div>
                <div className="col-xs-6" style={ { margin: '2%', marginLeft: '25%' }}>
                  <h3>Posting as 
                    <strong> { ipAddress } </strong> in
                    <strong> { address.city } </strong>
                  </h3>
                </div>
              </div>            
            </div>
          </Jumbotron>
        </div>
        <div className="container">
          <InfiniteScroll
            initialLoad={ false }
            hasMore={ this.props.fetchedPosts.hasMore }
            loadMore= { this.fetchThreads.bind(this) }
            loader={ this.loader() }
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

export default withFetchClientLocationDetails(
                  withFetchPosts(
                    withFetchComments(
                      LocationThreadContainer)))
