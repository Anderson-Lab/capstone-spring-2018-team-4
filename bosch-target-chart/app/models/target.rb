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

  validates :name, :department_id, :unit, :unit_type, presence: true
  # Skip valiation if updating a different attribute
  validates :compare_to_value, presence: true,
            if: Proc.new{ |t| (t.new_record? && t.is_numerical?) || t.compare_to_value_changed? }
  # Skip valiation if updating a different attribute
  validates :rule, presence: true, inclusion: { in: RULES },
            if: Proc.new{ |t| (t.new_record? && t.is_numerical?) || t.rule_changed? }
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_inclusion_of :unit_type, in: UNIT_TYPES

  scope :for_year, -> (year) {
    where(year: year)
  }

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
    self.compare_to_value = nil if self.is_qualitative?
  end

  def reset_indicator_values
    if self.is_numerical?
      self.indicators.update_all(value: nil, color: nil)
    else
      self.indicators.update_all(value: nil)
    end
  end
end
