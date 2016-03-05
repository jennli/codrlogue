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

class EducationsController < ApplicationController
end
