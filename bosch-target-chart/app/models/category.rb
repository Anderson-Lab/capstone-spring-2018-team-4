class Category < ApplicationRecord
  has_many :targets
  has_attached_file :icon, default_url: "categories/blank_category_icon.png"

  COLOR_HEX_VALUES_HASH = HashWithIndifferentAccess.new(YAML.load_file("#{Rails.root}/config/colors.yml"))[:chart_colors]

  validates_presence_of :name, :color
  validates_inclusion_of :color, in: COLOR_HEX_VALUES_HASH.values
  validates_attachment :icon, presence: true, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }

  # TODO: Before delete, unassign category from targets?
end
