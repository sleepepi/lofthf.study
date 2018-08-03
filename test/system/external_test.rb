# frozen_string_literal: true

require "application_system_test_case"

# Test external pages.
class ExternalTest < ApplicationSystemTestCase
  test "visit landing page" do
    visit root_url
    screenshot("visit-landing-page")
  end

  test "visit contact page" do
    visit contact_url
    screenshot("visit-contact-page")
  end

  test "visit version page" do
    visit version_url
    screenshot("visit-version-page")
  end
end
