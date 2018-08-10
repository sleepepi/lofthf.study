# frozen_string_literal: true

# Groups together folders. Categories can be archived (hidden), and reordered.
class Category < ApplicationRecord
  # Concerns
  include Sluggable
  include Squishable
  squish :name

  # Scopes
  scope :unarchived, -> { where(archived: false).order(Arel.sql("position nulls last")) }

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: true,
                   allow_nil: true

  # Relationships
  has_many :folders, -> { order(Arel.sql("position nulls last")) }
end
