require "application_system_test_case"

class CommentSummariesTest < ApplicationSystemTestCase
  setup do
    @comment_summary = comment_summaries(:one)
  end

  test "visiting the index" do
    visit comment_summaries_url
    assert_selector "h1", text: "Comment Summaries"
  end

  test "creating a Comment summary" do
    visit comment_summaries_url
    click_on "New Comment Summary"

    fill_in "Down votes", with: @comment_summary.down_votes
    fill_in "Up votes", with: @comment_summary.up_votes
    click_on "Create Comment summary"

    assert_text "Comment summary was successfully created"
    click_on "Back"
  end

  test "updating a Comment summary" do
    visit comment_summaries_url
    click_on "Edit", match: :first

    fill_in "Down votes", with: @comment_summary.down_votes
    fill_in "Up votes", with: @comment_summary.up_votes
    click_on "Update Comment summary"

    assert_text "Comment summary was successfully updated"
    click_on "Back"
  end

  test "destroying a Comment summary" do
    visit comment_summaries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Comment summary was successfully destroyed"
  end
end
