# == Schema Information
#
# Table name: educations
#
#  id          :integer          not null, primary key
#  school_name :string
#  school_link :string
#  grade_year  :datetime
#  level       :string
#  field       :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Education < ActiveRecord::Base
  belongs_to :user

  VALID_EDUCATION_LEVELS = %w(Unspecified Certificate Diploma Bachelor Masters PhD)

  validates :school_name, presence: true
  validates :grade_year, presence: true
  # To include only a set list of valid education levels, use 'inclusion: {within:...}'
  validates :level, presence: true, inclusion: {within: VALID_EDUCATION_LEVELS}

  validates :field, presence: true

end
