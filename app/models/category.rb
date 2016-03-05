# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  has_many :skills, dependent: :nullify

  VALID_CATEGORY_NAMES = %w(Lanuages Tools People)
  validates :name, presence: true, inclusion: { within: VALID_CATEGORY_NAMES }
end
