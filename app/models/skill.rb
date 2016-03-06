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

  validates :title, :rating, :user_id, :category_id, presence: true
  validates_associated :user, :category
end
