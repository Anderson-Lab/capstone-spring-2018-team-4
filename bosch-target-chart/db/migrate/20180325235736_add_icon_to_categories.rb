class AddIconToCategories < ActiveRecord::Migration[5.1]
  def change
    add_attachment :categories, :icon
  end
end
