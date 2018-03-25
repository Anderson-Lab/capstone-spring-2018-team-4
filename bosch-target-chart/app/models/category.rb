class Category < ApplicationRecord
  has_many :targets

  validates_presence_of :name, :color

  # TODO: Before delete, unassign category from targets?

  def image_name
    self.name.downcase.gsub(" ", "_")
  end
end
