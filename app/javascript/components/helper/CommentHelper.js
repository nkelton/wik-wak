class CommentHelper {
    static get = (postId, token) => {
        const COMMENTS_URL = `http://localhost:3000/api/v1/posts/${postId}/comments`
        return (
            fetch(COMMENTS_URL, {
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