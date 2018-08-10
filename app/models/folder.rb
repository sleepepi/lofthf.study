# frozen_string_literal: true

# Tracks files uploaded to the folder.
class Folder < ApplicationRecord
  # Concerns
  include Sluggable
  include Squishable
  squish :name

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: true,
                   allow_nil: true

  # Relationships
  belongs_to :category, counter_cache: true
  has_many_attached :files
end
