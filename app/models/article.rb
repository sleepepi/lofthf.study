# frozen_string_literal: true

# Creates mini article for internal website.
class Article < ApplicationRecord
  # Constants
  ORDERS = {
    "oldest" => "articles.publish_date",
    "latest" => "articles.publish_date desc",
    "title desc" => "articles.title desc",
    "title" => "articles.title"
  }
  DEFAULT_ORDER = "articles.publish_date desc"

  # Concerns
  include PgSearch::Model
  multisearchable against: [:title, :description], unless: :deleted_or_unpublished?

  include Deletable
  include Sluggable
  include Searchable
  def self.searchable_attributes
    %w(title description)
  end

  # Scopes
  scope :published, -> { current.where(published: true).where("publish_date <= ?", Time.zone.today) }

  # Validations
  validates :title, :description, :publish_date, presence: true
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: true,
                   allow_nil: true

  # Relationships
  belongs_to :user

  # Methods

  def deleted_or_unpublished?
    deleted? || !published?
  end
end
