class CreateJoinTableChartsTargets < ActiveRecord::Migration[5.1]
  def change
    create_join_table :charts, :targets do |t|
      t.references :chart, foreign_key: true
      t.references :target, foreign_key: true
    end
  end
end
