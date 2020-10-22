require "application_system_test_case"

class PostSummariesTest < ApplicationSystemTestCase
  setup do
    @post_summary = post_summaries(:one)
  end

  test "visiting the index" do
    visit post_summaries_url
    assert_selector "h1", text: "Post Summaries"
  end

  test "creating a Post summary" do
    visit post_summaries_url
    click_on "New Post Summary"

    fill_in "Down votes", with: @post_summary.down_votes
    fill_in "Up votes", with: @post_summary.up_votes
    click_on "Create Post summary"

    assert_text "Post summary was successfully created"
    click_on "Back"
  end

  test "updating a Post summary" do
    visit post_summaries_url
    click_on "Edit", match: :first

    fill_in "Down votes", with: @post_summary.down_votes
    fill_in "Up votes", with: @post_summary.up_votes
    click_on "Update Post summary"

    assert_text "Post summary was successfully updated"
    click_on "Back"
  end

  test "destroying a Post summary" do
    visit post_summaries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post summary was successfully destroyed"
  end
end
