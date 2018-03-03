class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators
  has_and_belongs_to_many :charts

  validates_presence_of :name
  validates_presence_of :department_id
  validates_presence_of :category_id
  validates_presence_of :unit
  validates_presence_of :unit_type
  validates_presence_of :update_frequency
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
