class CommentHelper {
    static get = (postId, token) => {
        const COMMENTS_URL = "http://localhost:3000/comments?"
        return (
            fetch(COMMENTS_URL + new URLSearchParams({
                post_id: postId
              }), {
                headers: {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "X-CSRF-Token": token
                }
              }).then(response => response.json())
        );
    }
}
export default CommentHelper