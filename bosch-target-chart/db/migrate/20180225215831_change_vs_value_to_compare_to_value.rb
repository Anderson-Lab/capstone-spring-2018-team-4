class ChangeVsValueToCompareToValue < ActiveRecord::Migration[5.1]
  def change
    rename_column :indicators, :vs_value, :compare_to_value
  end
end
