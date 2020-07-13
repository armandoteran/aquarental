class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.references :booking, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
