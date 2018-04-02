class AddColorToIndicator < ActiveRecord::Migration[5.1]
  def change
    add_column :indicators, :color, :string
  end
end
