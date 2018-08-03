# frozen_string_literal: true

require "application_system_test_case"

# Test internal pages.
class InternalTest < ApplicationSystemTestCase
  setup do
    @viewer = users(:viewer)
  end

  test "visit dashboard" do
    visit_login(@viewer)
    visit dashboard_url
    screenshot("visit-dashboard")
    assert_selector "h1", text: "Dashboard"
  end
end
