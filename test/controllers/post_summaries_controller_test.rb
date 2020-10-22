require 'test_helper'

class PostSummariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_summary = post_summaries(:one)
  end

  test "should get index" do
    get post_summaries_url
    assert_response :success
  end

  test "should get new" do
    get new_post_summary_url
    assert_response :success
  end

  test "should create post_summary" do
    assert_difference('PostSummary.count') do
      post post_summaries_url, params: { post_summary: { down_votes: @post_summary.down_votes, up_votes: @post_summary.up_votes } }
    end

    assert_redirected_to post_summary_url(PostSummary.last)
  end

  test "should show post_summary" do
    get post_summary_url(@post_summary)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_summary_url(@post_summary)
    assert_response :success
  end

  test "should update post_summary" do
    patch post_summary_url(@post_summary), params: { post_summary: { down_votes: @post_summary.down_votes, up_votes: @post_summary.up_votes } }
    assert_redirected_to post_summary_url(@post_summary)
  end

  test "should destroy post_summary" do
    assert_difference('PostSummary.count', -1) do
      delete post_summary_url(@post_summary)
    end

    assert_redirected_to post_summaries_url
  end
end
