class AddArchivedToDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :documents, :archived, :boolean, null: false, default: false
    add_index :documents, :archived
  end
end
