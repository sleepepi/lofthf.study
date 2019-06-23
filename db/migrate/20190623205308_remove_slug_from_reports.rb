class RemoveSlugFromReports < ActiveRecord::Migration[6.0]
  def change
    remove_index :reports, :slug
    remove_column :reports, :slug, :string
  end
end
