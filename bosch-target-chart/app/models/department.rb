class Department < ApplicationRecord
  has_many :targets
  has_many :charts #generally only one chart per year, but many charts over many years

  validates_presence_of :name
end
