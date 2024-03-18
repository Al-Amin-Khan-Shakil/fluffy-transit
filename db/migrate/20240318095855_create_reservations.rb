class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :pickup_address
      t.string :drop_address
      t.string :description
      t.string :contact
      t.date :pickup_date
      t.string :client_name
      t.integer :pet_amount
      t.string :warning_message
      t.boolean :pending, default: true
      t.boolean :on_way, default: false
      t.boolean :fulfilled, default: false
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
