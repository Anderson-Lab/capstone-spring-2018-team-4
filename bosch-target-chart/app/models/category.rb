class Category < ApplicationRecord
  has_many :targets, dependent: :destroy

  validates_presence_of :name

  def image_name
    self.name.downcase.gsub(" ", "_")
  end
end
