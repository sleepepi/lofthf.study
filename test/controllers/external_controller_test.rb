# frozen_string_literal: true

require "test_helper"

# Test public pages.
class ExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get root_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

  test "should get privacy policy" do
    get privacy_policy_url
    assert_response :success
  end

  test "should get version" do
    get version_url
    assert_response :success
  end

  test "should get version as json" do
    get version_url(format: "json")
    version = JSON.parse(response.body)
    assert_equal LoftHF::VERSION::STRING, version["version"]["string"]
    assert_equal LoftHF::VERSION::MAJOR, version["version"]["major"]
    assert_equal LoftHF::VERSION::MINOR, version["version"]["minor"]
    assert_equal LoftHF::VERSION::TINY, version["version"]["tiny"]
    if LoftHF::VERSION::BUILD.nil?
      assert_nil version["version"]["build"]
    else
      assert_equal LoftHF::VERSION::BUILD, version["version"]["build"]
    end
    assert_response :success
  end
end
