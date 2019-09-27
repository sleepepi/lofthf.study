# frozen_string_literal: true

# Tracks files uploaded to the folder.
class Folder < ApplicationRecord
  # Uploaders
  mount_uploader :zipped_folder, ZipUploader

  # Constants
  DOCS_PER_PAGE = 20

  # Concerns
  include Sluggable
  include Squishable
  squish :name

  # Validations
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: [:category_id] }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ },
                   exclusion: { in: %w(new edit create update destroy) },
                   uniqueness: { case_sensitive: false, scope: [:category_id] },
                   allow_nil: true

  # Relationships
  belongs_to :category, counter_cache: true
  has_many :documents, dependent: :destroy

  # Methods

  def attach_file!(file)
    documents.create(
      file: file,
      byte_size: file.size,
      filename: file.original_filename,
      content_type: Document.content_type(file.original_filename)
    )
  end

  def generate_zipped_folder!
    zip_name = "folder.zip"
    temp_zip_file = Tempfile.new(zip_name)
    begin
      # Initialize temp zip file.
      Zip::OutputStream.open(temp_zip_file) { |zos| }
      # Write to temp zip file.
      Zip::File.open(temp_zip_file, Zip::File::CREATE) do |zip|
        documents.each do |document|
          # Two arguments:
          # - The name of the file as it will appear in the archive
          # - The original file, including the path to find it
          zip.add(document.filename, document.file.path) if File.exist?(document.file.path) && File.size(document.file.path).positive?
        end
      end
      temp_zip_file.define_singleton_method(:original_filename) do
        zip_name
      end
      update zipped_folder: temp_zip_file
      # update file_size: zipped_folder.size # Cache after attaching to model.
    ensure
      # Close and delete the temp file
      temp_zip_file.close
      temp_zip_file.unlink
    end
  end
end
