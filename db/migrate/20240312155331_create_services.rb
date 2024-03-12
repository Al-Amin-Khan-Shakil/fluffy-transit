class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :min_cost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
