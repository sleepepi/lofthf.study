class AddProjectIdToReports < ActiveRecord::Migration[6.0]
  def change
    add_column :reports, :project_id, :bigint
    add_index :reports, :project_id
  end
end
