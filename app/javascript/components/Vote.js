import React from "react"
import PropTypes from "prop-types"
import VoteHelper from "./helper/VoteHelper"
class Vote extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      votes: 0 //this.props.votes
    }

    this.onUpVote = this.onUpVote.bind(this);
    this.onDownVote = this.onDownVote.bind(this);
  }

  vote(requestBody) {
    return VoteHelper.create(requestBody);
  }

  onUpVote() {
    var requestBody = this.props.voteBody;
    requestBody["value"] = 1;

    return this.vote(requestBody);
  }

  onDownVote() {
    var requestBody = this.props.voteBody;
    requestBody["value"] = -1;

    return this.vote(requestBody);
  }

  render () {
    return (
      <React.Fragment>
        <div className="voting">
          <div className="vote-buttons">
            <button className="upvote" onClick={ this.onUpVote }>
              Upvote
            </button>
            <button className="downvote" onClick={ this.onDownVote }>
              Downvote
            </button>
          </div>
          <div className="votes">Votes:  {this.state.votes}</div>
        </div>
      </React.Fragment>
    );
  }
}

Vote.propTypes = {
  votes: PropTypes.number,
};
export default Vote
