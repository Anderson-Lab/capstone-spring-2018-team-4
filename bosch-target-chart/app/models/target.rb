class Target < ApplicationRecord
  belongs_to :department
  belongs_to :category

  has_many :indicators
end
