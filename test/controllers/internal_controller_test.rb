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
end
