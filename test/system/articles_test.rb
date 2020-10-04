# frozen_string_literal: true

require "application_system_test_case"

# Test for editors to modify articles.
class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:published)
    @editor = users(:editor)
  end

  test "visit the index" do
    visit_login(@editor)
    visit articles_url
    assert_selector "h1", text: "Newsletters"
    screenshot("visit-articles-index")
  end

  test "create a article" do
    visit_login(@editor)
    visit articles_url
    screenshot("create-a-article")
    click_on "New article"
    fill_in "article[title]", with: "Article One"
    fill_in "article[description]", with: "This is a new article for the dashboard."
    fill_in "article[publish_date]", with: "12/10/2019"
    click_element "#article_publish_date"
    page.execute_script("datepickerReady();") # Clear datepicker
    screenshot("create-a-article")
    click_on "Create Article"
    assert_text "Article was successfully created"
    assert_selector "h1", text: "Articles"
    screenshot("create-a-article")
  end

  test "update a article" do
    visit_login(@editor)
    visit articles_url
    screenshot("update-a-article")
    click_on "Actions", match: :first
    screenshot("update-a-article")
    click_on "Edit"
    fill_in "article[title]", with: "Updated Title"
    screenshot("update-a-article")
    click_on "Update Article"
    assert_text "Article was successfully updated"
    assert_selector "h1", text: "Articles"
    screenshot("update-a-article")
  end

  test "destroy a article" do
    visit_login(@editor)
    visit articles_url
    screenshot("destroy-a-article")
    click_on "Actions", match: :first
    page.accept_confirm do
      click_on "Delete"
    end
    assert_text "Article was successfully deleted"
    screenshot("destroy-a-article")
  end
end
