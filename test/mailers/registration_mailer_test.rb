# frozen_string_literal: true

require "test_helper"

# Test that registration emails are created correctly.
class RegistrationMailerTest < ActionMailer::TestCase
  test "welcome email" do
    regular = users(:regular)
    mail = RegistrationMailer.welcome(regular)
    assert_equal "Welcome to LOFT-HF!", mail.subject
    assert_equal [regular.email], mail.to
    assert_match(/Your registration with LOFT-HF was successful\./, mail.body.encoded)
  end

  test "account registered email" do
    admin = users(:admin)
    regular = users(:regular)
    mail = RegistrationMailer.account_registered(admin, regular)
    assert_equal "Regular User registered for LOFT-HF", mail.subject
    assert_equal [admin.email], mail.to
    assert_match(
      /Regular User regular@example.com registered a new account on the LOFT-HF website\./,
      mail.body.encoded
    )
  end

  test "account confirmed email" do
    admin = users(:admin)
    regular = users(:regular)
    mail = RegistrationMailer.account_confirmed(admin, regular)
    assert_equal "Regular User confirmed their account for LOFT-HF", mail.subject
    assert_equal [admin.email], mail.to
    assert_match(
      /Regular User regular@example.com confirmed their account on the LOFT-HF website\./,
      mail.body.encoded
    )
  end

  test "account approved email" do
    regular = users(:regular)
    mail = RegistrationMailer.account_approved(regular)
    assert_equal "Your LOFT-HF account has been approved", mail.subject
    assert_equal [regular.email], mail.to
    assert_match(/Your account regular@example.com has been approved\./, mail.body.encoded)
  end
end
