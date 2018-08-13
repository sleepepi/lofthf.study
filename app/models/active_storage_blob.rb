# frozen_string_literal: true

# Add methods to existing ActiveStorageBlog model.
class ActiveStorageBlob < ActiveStorage::Blob
  include PgSearch
  multisearchable against: [:filename]
end
