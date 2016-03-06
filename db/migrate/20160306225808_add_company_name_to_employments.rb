class AddCompanyNameToEmployments < ActiveRecord::Migration
  def change
    add_column :employments, :company_name, :string
    add_column :employments, :company_link, :string
  end
end
