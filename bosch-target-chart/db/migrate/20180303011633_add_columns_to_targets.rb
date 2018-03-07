class AddColumnsToTargets < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :year, :integer
    add_column :targets, :unit_type, :string
  end
end
