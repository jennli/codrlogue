# == Schema Information
#
# Table name: employments
#
#  id         :integer          not null, primary key
#  job_title  :string
#  location   :string
#  start_year :datetime
#  end_year   :datetime
#  summary    :text
#  user_id    :integer
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Employment < ActiveRecord::Base
  belongs_to :user
  # belongs_to :company

  validates :job_title, presence: true
  validates :location, presence: true
  validates :start_year, presence: true
  validates :company_name, presence: true
end
