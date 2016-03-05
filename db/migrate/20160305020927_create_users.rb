class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.text :summary
      t.text :description
      t.boolean :admin
      t.boolean :is_available

      t.timestamps null: false
    end
    add_index :users, :email
  end
end
