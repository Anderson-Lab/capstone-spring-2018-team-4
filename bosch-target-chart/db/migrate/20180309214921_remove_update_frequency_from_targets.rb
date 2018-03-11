class RemoveUpdateFrequencyFromTargets < ActiveRecord::Migration[5.1]
  def change
    remove_column :targets, :update_frequency
  end
end
