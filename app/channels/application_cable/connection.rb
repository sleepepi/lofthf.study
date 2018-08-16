# frozen_string_literal: true

module ApplicationCable
  # Only allow logged in users to receive channel updates.
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags "ActionCable", current_user.email
    end

    protected

    def find_verified_user
      env["warden"].user || reject_unauthorized_connection
    end
  end
end
