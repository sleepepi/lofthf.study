# frozen_string_literal: true

# Defines the user model, relationships, and permissions.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Callbacks
  after_commit :new_registration_in_background!, on: :create

  # Constants
  ORDERS = {
    "activity desc" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc",
    "activity" => "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END)",
    "logins desc" => "users.sign_in_count desc",
    "logins" => "users.sign_in_count"
  }
  DEFAULT_ORDER = "(CASE WHEN (users.current_sign_in_at IS NULL) THEN users.created_at ELSE users.current_sign_in_at END) desc"

  # Concerns
  include Deletable
  include Forkable
  include Squishable
  squish :full_name

  include Strippable
  strip :username

  include Searchable
  def self.searchable_attributes
    %w(full_name email username)
  end

  include PgSearch
  multisearchable against: [:full_name, :email, :username]
  # pg_search_scope :search_for, against: [:full_name, :email, :username],
  #                              using: {
  #                                tsearch: { prefix: true, any_word: true }
  #                              }

  # Validations
  validates :full_name, presence: true
  validates :full_name, format: { with: /\A.+\s.+\Z/, message: "must include first and last name" }
  validates :username, presence: true
  validates :username, format: {
                         with: /\A[a-zA-Z0-9]+\Z/i,
                         message: "may only contain letters or digits"
                       },
                       exclusion: { in: %w(new edit show create update destroy) },
                       allow_blank: true,
                       uniqueness: { case_sensitive: false }

  # Methods

  def check_approval_email
    return unless approved? && approval_sent_at.nil?
    update(approval_sent_at: Time.zone.now)
    send_approval_email_in_background!
  end

  def disposable_email?
    false
  end

  # Overriding Devise built-in active_for_authentication? method.
  def active_for_authentication?
    super && !deleted? && approved?
  end

  # Override Devise built-in password reset notification email method
  def send_reset_password_instructions
    return if deleted?
    super
  end

  # Override Devise built-in unlock instructions notification email method
  def send_unlock_instructions
    return if deleted?
    super
  end

  def send_confirmation_instructions
    return if disposable_email?
    super
  end

  def send_on_create_confirmation_instructions
    return if disposable_email?
    send_welcome_email_in_background!
  end

  def send_welcome_email_in_background!
    fork_process :send_welcome_email!
  end

  def new_registration_in_background!
    fork_process :new_registration!
  end

  def send_approval_email_in_background!
    fork_process :send_approval_email!
  end

  private

  def send_welcome_email!
    RegistrationMailer.welcome(self).deliver_now if EMAILS_ENABLED
  end

  def new_registration!
    return unless EMAILS_ENABLED
    User.current.where(admin: true).find_each do |admin|
      RegistrationMailer.user_registered(admin, self).deliver_now
    end
  end

  def send_approval_email!
    RegistrationMailer.account_approved(self).deliver_now if EMAILS_ENABLED
  end
end
