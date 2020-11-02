import React from "react"
import PropTypes from "prop-types"
import PostForm from "./PostForm"
import ThreadContainer from "./ThreadContainer"
import Jumbotron from 'react-bootstrap/Jumbotron'
import Button from 'react-bootstrap/Button'
import InfiniteScroll from 'react-infinite-scroller';
import withFetchClientLocationDetails from './withFetchClientLocationDetails'
import withFetchPosts from './withFetchPosts'
import withFetchComments from './withFetchComments'
import LoadSpinner from './LoadSpinner'
import FormModal from './FormModal'
import useModal from './useModal'
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

  render () {      
    const {
      address,
      ipAddress,
    }= this.props.clientLocationDetails

    const {
      toggleModal,
    }= this.props

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
                  <FormModal 
                    button = {
                     <Button 
                        onClick={ toggleModal }
                        variant="success">
                         Make Post
                     </Button>
                    }
                    title={ "Post" }
                    form={ <PostForm /> }
                    {...this.props }
                  />
                </div>
                <div className="col-xs-6" style={ { margin: '2%', marginLeft: '25%' }}>
                  <h3>Posting as 
                    <strong> { ipAddress } </strong> in
                    <strong> { address.city ? address.city : address.county } </strong>
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
            loader={ 
              <LoadSpinner key={ 0 } 
                animation={ "border" }
                role={ "status" }
                message= { "Loading..." }
              />  
            }
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
                      useModal(
                        LocationThreadContainer))))
