import React from "react"
import PostHelper from "./helper/PostHelper"
const withFetchPosts = (WrappedComponent) => {
    class withFetchPosts extends React.Component {
        constructor(props) {
            super(props);
            
            this.state = {
                fetchedPosts: {
                    results: [],
                    offset: 0,
                    limit: 3,
                    hasMore: true,
                    loading: true
                }
            }

            this.fetchPosts = this.fetchPosts.bind(this);
        }

        fetchPosts() {
            const {
                clientLocationDetails
            }= this.props;
          
            const {
                offset, 
                limit,
                results
            }= this.state.fetchedPosts

            return PostHelper.get(
                    [clientLocationDetails.lat, clientLocationDetails.lng],
                    offset,
                    limit,
                    this.props.authenticity_token
                ).then((posts) => {
                const newOffset = posts.length
                const hasMore = newOffset === limit;

                this.setState({
                    fetchedPosts: {
                        results: results.concat(posts),
                        offset: offset + newOffset, 
                        limit: limit,
                        hasMore: hasMore,
                        loading: false
                    }
                });

                return posts;
            })
        }

        render() {
            const {
                fetchedPosts,
            }= this.state;

            return (
                <WrappedComponent
                    fetchedPosts={ fetchedPosts }
                    fetchPosts={ this.fetchPosts }
                    {...this.props}
                />
            );
        }
    }
  
    withFetchPosts.displayName = `withFetchPosts(${WrappedComponent.name})`;

    return withFetchPosts;
  };
  
  export default withFetchPosts;