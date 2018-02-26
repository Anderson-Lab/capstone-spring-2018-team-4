class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators

  validates_presence_of :name
  validates_presence_of :department_id
  validates_presence_of :category_id
  validates_presence_of :unit
  validates_presence_of :update_frequency
end
