class PostHelper {
    static get = (location, offset, limit, token) => {
        const POSTS_URL = "http://localhost:3000/posts?"
        return (
            fetch(POSTS_URL + new URLSearchParams({
                location: location,
                offset: offset,
                limit: limit
            }), {
                headers:  {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "X-CSRF-Token": token
                }
            }).then(response => response.json())
        );
    }
}
export default PostHelper