require 'active_record'

ActiveRecord::Schema.define do
  create_table :products do |table|
    table.column :product_code, :string
    table.column :name, :string
    table.column :price, :decimal, precision: 12, scale: 2
  end
end
