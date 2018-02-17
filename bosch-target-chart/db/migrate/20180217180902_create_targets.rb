class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.string :name
      t.references :department, foreign_key: true
      t.references :category, foreign_key: true
      t.string :unit, limit: 32
      t.string :update_frequency
      t.string :comments

      t.timestamps
    end
  end
end
