class DropCompaniesTable < ActiveRecord::Migration
  def change
    remove_column :employments, :company_id, :integer
    drop_table :companies
  end
end
