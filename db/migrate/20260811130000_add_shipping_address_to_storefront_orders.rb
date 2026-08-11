# frozen_string_literal: true

class AddShippingAddressToStorefrontOrders < ActiveRecord::Migration[7.2]
  def change
    change_table :storefront_orders do |t|
      t.string :shipping_name, limit: 160
      t.string :shipping_line1, limit: 160
      t.string :shipping_line2, limit: 160
      t.string :shipping_city, limit: 120
      t.string :shipping_region, limit: 120
      t.string :shipping_postal_code, limit: 24
      t.string :shipping_country, limit: 64
    end
  end
end
