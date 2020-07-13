class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :category
      t.string :picture_url
      t.integer :price_day
      t.integer :price_hour
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :state

      t.timestamps
    end
  end
end
