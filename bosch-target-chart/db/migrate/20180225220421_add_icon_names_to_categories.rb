class AddIconNamesToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :icon_name, :string
  end
end
