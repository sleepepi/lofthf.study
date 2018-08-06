# frozen_string_literal: true

# Generic mailer class defines layout and email sender.
class ApplicationMailer < ActionMailer::Base
  default from: "#{ENV["website_name"]} <#{ActionMailer::Base.smtp_settings[:email]}>"
  add_template_helper(EmailHelper)
  layout "mailer"

  protected

  def setup_email
    location = "app/assets/images/logos/loft-logo-v1-no-background.png"
    attachments.inline["loft-hf-logo.png"] = File.read(location)
  rescue
    nil
  end
end
