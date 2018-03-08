class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators
  has_and_belongs_to_many :charts

  validates :name, :department_id, :category_id, :unit, :unit_type, :update_frequency, presence: true
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  UNIT_TYPES = [
    t(:targets)[:fields][:unit_type][:numerical],
    t(:targets)[:fields][:unit_type][:percentage],
    t(:targets)[:fields][:unit_type][:qualitative],
  ]
end
