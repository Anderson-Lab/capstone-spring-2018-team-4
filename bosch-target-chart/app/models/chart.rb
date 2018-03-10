class Chart < ApplicationRecord
  belongs_to :department, optional: true

  has_and_belongs_to_many :targets

  validates_presence_of :name
  validates :year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # There should only be 1 target for each year per department_id (including nil)
  validates_uniqueness_of :year, scope: [ :department_id ]

  scope :for_plant, -> {
    where(department: nil)
  }

  scope :for_departments, -> {
    joins(:department)
  }

  scope :for_year, -> (year) {
    where(year: year)
  }

  def self.years_for_select(department=nil)
    return department.charts.order(:year).pluck(:year) if department
    
    existing_years  = Chart.all.order(:year).pluck(:year).uniq
    next_year       = Time.now.year + 1

    if existing_years.include?(next_year)
      existing_years
    else
      existing_years << next_year
    end
  end
end
