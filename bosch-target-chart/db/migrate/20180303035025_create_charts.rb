class CreateCharts < ActiveRecord::Migration[5.1]
  def change
    create_table :charts do |t|
      t.string :name
      t.references :department, foreign_key: true
      t.integer :year

      t.timestamps
    end
  end
end
