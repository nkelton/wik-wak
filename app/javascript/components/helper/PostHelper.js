class PostHelper {
    static get = (location, offset, limit, token) => {
        const POSTS_URL = "http://localhost:3000/api/v1/posts?"
        return (
            fetch(POSTS_URL + new URLSearchParams({
                lat: location[0],
                lng: location[1],
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

    static post = (data) => {
        const csrfToken = $('meta[name=csrf-token]').attr('content');
        const POSTS_URL = "http://localhost:3000/api/v1/posts"
        
        return(
            fetch(POSTS_URL, {
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
export default PostHelper