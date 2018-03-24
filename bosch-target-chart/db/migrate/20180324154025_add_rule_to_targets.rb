class AddRuleToTargets < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :rule, :integer
  end
end
