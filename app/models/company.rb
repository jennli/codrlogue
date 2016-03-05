# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ActiveRecord::Base
  has_many :employments, dependent: :nullify
  has_many :users, through: :employments

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
