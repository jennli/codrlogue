class Category < ActiveRecord::Base
  has_many :skills, dependent: :nullify 
end
