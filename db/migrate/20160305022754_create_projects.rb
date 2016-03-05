class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :project_link
      t.string :github_link
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
