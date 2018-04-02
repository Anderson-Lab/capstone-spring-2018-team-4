class Indicator < ApplicationRecord
  belongs_to :target

  COLORS = [
    I18n.t(:indicators)[:fields][:color][:green],
    I18n.t(:indicators)[:fields][:color][:yellow],
    I18n.t(:indicators)[:fields][:color][:red],
  ]

  validates :name, presence: true
  validates :value, numericality: true, presence: true, if: Proc.new{ |i| i.target && i.target.is_numerical? }
  validates :color, inclusion: { in: COLORS }, presence: true, if: Proc.new{ |i| i.target && i.target.is_qualitative? }

  def is_positive?
    if self.target.is_qualitative?
      self.color == Indicator::COLORS[0]
    else
      eval("!(#{self.difference} #{self.target.codified_rule} 0)")
    end
  end

  def is_neutral?
    if self.target.is_qualitative?
      self.color == Indicator::COLORS[1]
    else
      false
    end
  end

  def is_negative?
    if self.target.is_qualitative?
      self.color == Indicator::COLORS[2]
    else
      eval("#{self.difference} #{self.target.codified_rule} 0")
    end
  end

  def difference
    (self.target.compare_to_value || 0) - (self.value || 0)
  end
end
