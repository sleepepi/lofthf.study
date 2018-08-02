# frozen_string_literal: true

require "application_system_test_case"

# Test external pages.
class ExternalTest < ApplicationSystemTestCase
  test "visiting the landing page" do
    visit root_url
    screenshot("visit-landing-page")
  end

  test "visiting the contact page" do
    visit contact_url
    screenshot("visit-contact-page")
  end

  test "visiting the version page" do
    visit version_url
    screenshot("visit-version-page")
  end
end
