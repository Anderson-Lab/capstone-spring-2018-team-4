class Department < ApplicationRecord
  has_many :targets
  has_many :charts

  validates_presence_of :name
  after_create :build_charts

  private

  def build_charts
    Chart
  end
end
