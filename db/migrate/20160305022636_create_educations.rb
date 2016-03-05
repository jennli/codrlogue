class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :school_name
      t.string :school_link
      t.datetime :grade_year
      t.string :level
      t.string :field
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
