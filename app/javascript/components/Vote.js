import React from "react"
import PropTypes from "prop-types"
class Vote extends React.Component {
  render () {
    return (
      <React.Fragment>
        <div className="voting">
          <div className="vote-buttons">
            <button className="upvote" onClick={() => console.log("upvote")}>
              Upvote
            </button>
            <button className="downvote" onClick={() => console.log("downvote")}>
              Downvote
            </button>
          </div>
          <div className="votes">Votes: 0</div>
        </div>
      </React.Fragment>
    );
  }
}

Vote.propTypes = {
  onUpVote: PropTypes.func,
  onDownVote: PropTypes.func
};
export default Vote
