class AddCompareToValueToTargets < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :compare_to_value, :decimal, precision: 22, scale: 10
  end
end
