require 'test_helper'

class CommentSummariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment_summary = comment_summaries(:one)
  end

  test "should get index" do
    get comment_summaries_url
    assert_response :success
  end

  test "should get new" do
    get new_comment_summary_url
    assert_response :success
  end

  test "should create comment_summary" do
    assert_difference('CommentSummary.count') do
      post comment_summaries_url, params: { comment_summary: { down_votes: @comment_summary.down_votes, up_votes: @comment_summary.up_votes } }
    end

    assert_redirected_to comment_summary_url(CommentSummary.last)
  end

  test "should show comment_summary" do
    get comment_summary_url(@comment_summary)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_summary_url(@comment_summary)
    assert_response :success
  end

  test "should update comment_summary" do
    patch comment_summary_url(@comment_summary), params: { comment_summary: { down_votes: @comment_summary.down_votes, up_votes: @comment_summary.up_votes } }
    assert_redirected_to comment_summary_url(@comment_summary)
  end

  test "should destroy comment_summary" do
    assert_difference('CommentSummary.count', -1) do
      delete comment_summary_url(@comment_summary)
    end

    assert_redirected_to comment_summaries_url
  end
end
