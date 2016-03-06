# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  title       :string
#  rating      :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Skill < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :title, :user_id, :category_id, presence: true
  validates :rating, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 5 }
  validates_associated :user, :category
end
