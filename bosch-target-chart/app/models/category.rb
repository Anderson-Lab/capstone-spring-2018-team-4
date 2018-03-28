class Category < ApplicationRecord
  has_many :targets
  has_attached_file :icon, default_url: "app/assets/images/categories/default_category_icon.png"

  validates_presence_of :name, :color

  # TODO: Before delete, unassign category from targets?

  def image_name
    self.name.downcase.gsub(" ", "_")
  end
end
