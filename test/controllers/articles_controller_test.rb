require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @editor = users(:editor)
    @regular = users(:regular)
    @published = articles(:published)
    @draft = articles(:draft)
  end

  def article_params
    {
      title: "New Article",
      slug: "new-article",
      description: "My new article about something.\n**This is bold**\nThe end.",
      publish_date: "12/5/2019",
      published: "1"
    }
  end

  test "should get index as editor" do
    login(@editor)
    get articles_url
    assert_response :success
  end

  test "should get index as regular" do
    login(@regular)
    get articles_url
    assert_response :success
  end

  test "should get new as editor" do
    login(@editor)
    get new_article_url
    assert_response :success
  end

  test "should not get new as regular" do
    login(@regular)
    get new_article_url
    assert_redirected_to dashboard_url
  end

  test "should create article as editor" do
    login(@editor)
    assert_difference("Article.count") do
      post articles_url, params: { article: article_params }
    end
    assert_redirected_to article_url(Article.last)
  end

  test "should not create article as regular" do
    login(@regular)
    assert_difference("Article.count", 0) do
      post articles_url, params: { article: article_params }
    end
    assert_redirected_to dashboard_url
  end

  test "should show published article as editor" do
    login(@editor)
    get article_url(@published)
    assert_response :success
  end

  test "should show published article as regular" do
    login(@regular)
    get article_url(@published)
    assert_response :success
  end

  test "should show draft article as editor" do
    login(@editor)
    get article_url(@draft)
    assert_response :success
  end

  test "should not show draft article as regular" do
    login(@regular)
    get article_url(@draft)
    assert_redirected_to articles_url
  end

  test "should get edit as editor" do
    login(@editor)
    get edit_article_url(@published)
    assert_response :success
  end

  test "should not get edit regular" do
    login(@regular)
    get edit_article_url(@published)
    assert_redirected_to dashboard_url
  end

  test "should update article as editor" do
    login(@editor)
    patch article_url(@published), params: { article: article_params }
    @published.reload
    assert_redirected_to article_url(@published)
  end

  test "should not update article as regular" do
    login(@regular)
    patch article_url(@published), params: { article: article_params }
    assert_redirected_to dashboard_url
  end

  test "should destroy article as editor" do
    login(@editor)
    assert_difference("Article.current.count", -1) do
      delete article_url(@published)
    end
    assert_redirected_to articles_url
  end

  test "should not destroy article as regular" do
    login(@regular)
    assert_difference("Article.current.count", 0) do
      delete article_url(@published)
    end
    assert_redirected_to dashboard_url
  end
end
