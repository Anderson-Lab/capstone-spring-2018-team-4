class Department < ApplicationRecord
  has_many :targets

  validates_presence_of :name
end
