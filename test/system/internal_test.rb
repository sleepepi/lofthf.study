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

  test "visit reports" do
    visit_login(@viewer)
    visit reports_url
    screenshot("visit-reports")
    assert_selector "h1", text: "Reports"
  end

  test "visit data health" do
    visit_login(@viewer)
    visit data_health_url
    screenshot("visit-data-health")
    assert_selector "h1", text: "Data Health"
  end

  test "visit report card" do
    visit_login(@viewer)
    visit report_card_url
    screenshot("visit-report-card")
    assert_selector "h1", text: "Report Card"
  end
end
