class Chart < ApplicationRecord
  belongs_to :department

  has_and_belongs_to_many :targets

  validates_presence_of :name
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # There should not have two or more charts with the same year
  validates_uniqueness_of :year, scope: [ :department_id ]
end
