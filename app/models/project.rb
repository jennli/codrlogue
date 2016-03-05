# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :text
#  project_link :string
#  github_link  :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Project < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

end
