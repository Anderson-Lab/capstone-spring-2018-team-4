class CreateIndicators < ActiveRecord::Migration[5.1]
  def change
    create_table :indicators do |t|
      t.references :target, foreign_key: true
      t.string :name
      t.decimal :value, precision: 22, scale: 10
      t.decimal :vs_value, precision: 22, scale: 10

      t.timestamps
    end
  end
end
