class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators, dependent: :destroy
  has_and_belongs_to_many :charts

  MAX_INDICATORS = 3

  UNIT_TYPES = [
    I18n.t(:targets)[:fields][:unit_type][:numerical],
    I18n.t(:targets)[:fields][:unit_type][:qualitative]
  ]

  RULES = [
    I18n.t(:targets)[:fields][:rule][:greater_than_or_equal],
    I18n.t(:targets)[:fields][:rule][:less_than_or_equal]
  ]

  validates :name, :department_id, :category_id, :unit, :unit_type, presence: true
  validates :compare_to_value, presence: true,
            unless: Proc.new{ |t| t.is_qualitative? || t.unit_type_changed? }
  validates :rule, presence: true, inclusion: { in: RULES },
            unless: Proc.new{ |t| t.is_qualitative? || t.unit_type_changed? }
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_inclusion_of :unit_type, in: UNIT_TYPES

  before_update :reset_compare_to_value, if: :unit_type_changed?
  before_update :reset_indicator_values, if: :unit_type_changed?

  def is_numerical?
    self.unit_type == Target::UNIT_TYPES[0]
  end

  def is_qualitative?
    self.unit_type == Target::UNIT_TYPES[1]
  end

  def codified_rule
    self.rule == I18n.t(:targets)[:fields][:rule][:greater_than_or_equal] ? ">=" : "<="
  end

  private

  def reset_compare_to_value
    if self.is_qualitative?
      self.compare_to_value = nil
    end
  end

  def reset_indicator_values
    if self.is_numerical?
      self.indicators.update_all(value: nil, color: nil)
    else
      self.indicators.update_all(value: nil)
    end
  end
end
