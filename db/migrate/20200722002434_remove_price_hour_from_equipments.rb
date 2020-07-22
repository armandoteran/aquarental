class RemovePriceHourFromEquipments < ActiveRecord::Migration[6.0]
  def change
    remove_column :equipment, :price_hour, :date
  end
end
