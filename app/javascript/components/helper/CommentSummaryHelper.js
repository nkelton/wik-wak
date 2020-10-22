class CommentSummaryHelper {
    static get = (searchParams) => {
        const csrfToken = $('meta[name=csrf-token]').attr('content');
        const COMMENT_SUMMARY_URL = "http://localhost:3000/comment_summaries"
        return (
            fetch(COMMENT_SUMMARY_URL + new URLSearchParams(searchParams), {
                headers:  {
                  "Content-Type": "application/json",
                  "Accept": "application/json",
                  "X-CSRF-Token": csrfToken
                },
            }).then(response => response.json())
        );
    }
}
export default CommentSummaryHelper