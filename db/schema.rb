require 'active_record'
require_relative '../config/connection_params'

ActiveRecord::Base.establish_connection(CONNECTION_PARAMS)

ActiveRecord::Schema.define do
  create_table :products do |table|
    table.column :product_code, :string
    table.column :name, :string
    table.column :price, :decimal, precision: 12, scale: 2
  end
end
