class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators, dependent: :destroy
  has_and_belongs_to_many :charts

  UNIT_TYPES = [
    I18n.t(:targets)[:fields][:unit_type][:numerical],
    I18n.t(:targets)[:fields][:unit_type][:qualitative],
  ]

  validates :name, :department_id, :category_id, :unit, :unit_type, presence: true
  validates :compare_to_value, presence: true, unless: :is_qualitative?
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_inclusion_of :unit_type, in: UNIT_TYPES

  before_update :reset_indicator_values, if: :unit_type_changed?

  def is_numerical?
    self.unit_type == Target::UNIT_TYPES[0]
  end

  def is_qualitative?
    self.unit_type == Target::UNIT_TYPES[1]
  end

  private

  def reset_indicator_values
    if self.unit_type == Target::UNIT_TYPES[0]
      self.indicators.each{ |i| i.update_attributes(value: 0, color: nil) }
    else
      self.indicators.each{ |i| i.update_attribute(:value, nil) }
    end
  end
end
