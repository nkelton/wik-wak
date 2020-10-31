import React from "react"
import CommentHelper from "./helper/CommentHelper"
const withFetchComments = (WrappedComponent) => {
    class withFetchComments extends React.Component {
        constructor(props) {
            super(props);
            
            this.state = {
                fetchedComments: {
                    results: [],
                    loading: true
                }
            }

            this.fetchComments = this.fetchComments.bind(this);
        }

        fetchComments(posts) {
            const {
                results
            }= this.state.fetchedComments

            return Promise.all(posts.map((post) => {
                return CommentHelper.get(post.id["$oid"], this.props.authenticity_token);
            })).then((comments) => {
                this.setState({
                    fetchedComments: {
                        results: results.concat(comments),
                        loading: false
                    }
                })

                return comments
            })
        }

        render() {
            const {
                fetchedComments,
            }= this.state;

            return (
                <WrappedComponent
                    fetchedComments={ fetchedComments }
                    fetchComments={ this.fetchComments }
                    {...this.props}
                />
            );
        }
    }
  
    withFetchComments.displayName = `withFetchComments(${WrappedComponent.name})`;

    return withFetchComments;
  };
  
  export default withFetchComments;