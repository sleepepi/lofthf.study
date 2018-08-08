# frozen_string_literal: true

require "test_helper"

# Test internal pages.
class InternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewer = users(:viewer)
  end

  test "should get dashboard" do
    login(@viewer)
    get dashboard_url
    assert_response :success
  end

  test "should get directory" do
    login(@viewer)
    get directory_url
    assert_response :success
  end

  test "should get folder" do
    login(@viewer)
    get folder_url
    assert_response :success
  end

  test "should get reports" do
    login(@viewer)
    get reports_url
    assert_response :success
  end

  test "should get data health" do
    login(@viewer)
    get data_health_url
    assert_response :success
  end

  test "should get report card" do
    login(@viewer)
    get report_card_url
    assert_response :success
  end

  test "should get search" do
    login(@viewer)
    get search_url
    assert_response :success
  end
end
