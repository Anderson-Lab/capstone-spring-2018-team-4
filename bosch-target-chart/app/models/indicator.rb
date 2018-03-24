class Indicator < ApplicationRecord
  belongs_to :target

  COLORS = [
    I18n.t(:indicators)[:fields][:color][:green],
    I18n.t(:indicators)[:fields][:color][:yellow],
    I18n.t(:indicators)[:fields][:color][:red],
  ]

  validates :name, presence: true
  validates :value, numericality: true, presence: true
  
  def is_positive?
    if self.target.is_qualitative?
      self.value == 0
    else
      self.value && self.value >= self.target.compare_to_value
    end
  end

  def is_neutral?
    if self.target.is_qualitative?
      self.value == 1
    else
      false
    end
  end

  def is_negative?
    if self.target.is_qualitative?
      self.value == 2
    else
      self.value && self.value < self.target.compare_to_value
    end
  end
end
