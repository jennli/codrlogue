class Company < ActiveRecord::Base
  has_many :employments, dependent: :nullify
  has_many :users, through: :employments

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
