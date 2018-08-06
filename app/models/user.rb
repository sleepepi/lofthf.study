# frozen_string_literal: true

# Defines the user model, relationships, and permissions.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable
  include Squishable
  squish :full_name

  include Strippable
  strip :username

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

  # Overriding Devise built-in active_for_authentication? method.
  def active_for_authentication?
    super && !deleted? && approved?
  end

  def disposable_email?
    false
  end
end
