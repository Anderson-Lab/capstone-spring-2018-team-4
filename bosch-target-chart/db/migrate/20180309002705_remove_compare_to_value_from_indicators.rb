class RemoveCompareToValueFromIndicators < ActiveRecord::Migration[5.1]
  def change
    remove_column :indicators, :compare_to_value
  end
end
