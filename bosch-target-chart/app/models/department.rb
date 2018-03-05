class Department < ApplicationRecord
  has_many :targets
  has_many :charts

  validates_presence_of :name
end
