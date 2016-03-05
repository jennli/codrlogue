class Employment < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :job_title, presence: true
  validates :location, presence: true
  validates :start_year, presence: true
end
