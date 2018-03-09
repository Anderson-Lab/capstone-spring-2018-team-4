class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators, dependent: :destroy
  has_and_belongs_to_many :charts

  validates :name, :department_id, :category_id, :unit, :unit_type, :update_frequency, presence: true
  validates :compare_to_value, presence: true, unless: :is_qualitative?
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  UNIT_TYPES = [
    I18n.t(:targets)[:fields][:unit_type][:numerical],
    I18n.t(:targets)[:fields][:unit_type][:qualitative],
  ]

  def is_qualitative?
    self.unit_type == Target::UNIT_TYPES[1]
  end
end
