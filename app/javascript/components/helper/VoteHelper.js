class VoteHelper {
    static create = (requestParams) => {
        const csrfToken = $('meta[name=csrf-token]').attr('content');
        const VOTES_URL = "http://localhost:3000/votes"
        return (
            fetch(VOTES_URL, {
                method: 'POST',
                headers:  {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "X-CSRF-Token": csrfToken
                },
                body: JSON.stringify(requestParams)
            }).then(response => response.json())
        );
    }
}
export default VoteHelper