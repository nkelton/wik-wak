class PostSummaryHelper {
    static get = (searchParams) => {
        const csrfToken = $('meta[name=csrf-token]').attr('content');
        const POST_SUMMARY_URL = "http://localhost:3000/post_summaries?"

        return (
            fetch(POST_SUMMARY_URL + new URLSearchParams(searchParams), {
                headers:  {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "X-CSRF-Token": csrfToken
                },
            }).then(response => response.json())
        );
    }
}
export default PostSummaryHelper