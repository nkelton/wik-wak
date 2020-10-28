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

    static post = (postId, data) => {
      const csrfToken = $('meta[name=csrf-token]').attr('content');
      const COMMENTS_URL = `http://localhost:3000/api/v1/posts/${postId}/comments`
      
      return (
        fetch(COMMENTS_URL, {
          method: 'POST',
          headers:  {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-CSRF-Token": csrfToken
          },
          body: JSON.stringify(data)
        }).then(response => response.json())
      );
    }
}
export default CommentHelper