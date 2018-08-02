# frozen_string_literal: true

# Generic mailer class defines layout and email sender.
class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV["website_name"]} <#{ActionMailer::Base.smtp_settings[:email]}>"
  layout "mailer"
end
