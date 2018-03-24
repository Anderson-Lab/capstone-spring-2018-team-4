class Indicator < ApplicationRecord
  belongs_to :target

  validates :name, presence: true
  validates :value, numericality: true, presence: true
end
