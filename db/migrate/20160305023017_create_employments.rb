class CreateEmployments < ActiveRecord::Migration
  def change
    create_table :employments do |t|
      t.string :job_title
      t.string :location
      t.datetime :start_year
      t.datetime :end_year
      t.text :summary
      t.references :user, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
