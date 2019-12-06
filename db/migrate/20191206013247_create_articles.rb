class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.date :publish_date
      t.boolean :published, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.datetime :deleted_at
      t.bigint :user_id
      t.timestamps

      t.index :slug, unique: true
      t.index :published
      t.index :deleted
      t.index :user_id
    end
  end
end
